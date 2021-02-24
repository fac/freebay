class BidsController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :load_listing, only: [:new, :create, :update, :destroy]
  before_action :check_status, only: [:new, :create, :update, :destroy]

  def index
    @bids = current_user.bids.includes(:listing).order("created_at DESC")
  end

  def new
    if @listing.ended?
      flash[:notice] = "Listing has ended"
      redirect_to root_path and return
    end

    @bid = Bid.new(listing: @listing, user: current_user)
  end

  def update
    redirect_to listing_path(@listing)
  end

  def destroy
    redirect_to listing_path(@listing)
  end

  def create
    @listing.lock!

    # don't use `@listing.bids.build` since we don't want `@listing` to be aware of
    # unsaved bids
    @bid = Bid.new(bid_params.merge(listing: @listing, user: current_user))
    unless @bid.valid?
      flash[:error] = @bid.errors.full_messages.to_sentence
      render 'new', status: :unprocessable_entity and return
    end

    result = autobid(@bid)
    if result.success?
      Bid.transaction do
        @bid.save!

        if result.current_price
          logger.info "Setting current_price to #{result.current_price}"
          @bid.listing.update_attribute :current_price, result.current_price
        end

        OutbidNotifier.send_outbid_notice(result.outbid, @bid).deliver if result.outbid
      end
    end

    if result.error.blank?
      flash[:notice] = result.message
      redirect_to listing_path(@listing)
    else
      flash[:error] = result.error
      redirect_to new_listing_bid_path(@listing)
    end
  end

  private

    def load_listing
      @listing = Listing.find(params[:listing_id])
    end

    def check_status
      unless @listing.active?
        flash[:notice] = "Hold your horses, bidding hasn't started yet! 🐴"
        redirect_to listing_path(@listing)
      end
    end

    def bid_params
      params.require(:bid).permit(:amount)
    end

    def autobid(bid)
      winning_bid = bid.listing.winning_bid
      if winning_bid.nil?
        logger.info "First bid. Setting listing #{bid.listing.id} current price to #{bid.listing.current_price}"

        return OpenStruct.new(
          success?: true,
          current_price: bid.listing.starting_price,
          message: "Your bid was successful - you're the highest bidder! The current price is #{number_to_currency bid.listing.starting_price}"
        )
      end

      logger.info "New bid! Current winning bid #{winning_bid.id} amount is #{winning_bid.amount}. Listing current price is #{bid.listing.current_price}"

      if bid.user_id == winning_bid.user_id
        logger.info "User #{bid.user_id} trying to increase maximum bid"
        # if this is a new bid by the same user, only accept it if it's higher (i.e. they're increasing their max bid)
        if bid.amount <= winning_bid.amount
          logger.info "Amount of #{bid.amount} is not higher than existing max bid of #{winning_bid.amount}"
          return OpenStruct.new(success?: false, error: "Your bid must be greater than your existing maximum bid of #{number_to_currency winning_bid.amount}")
        else
          return OpenStruct.new(success?: true, message: "Your maximum bid has been increased to #{number_to_currency bid.amount}. Good luck!")
        end
      else
        if bid.amount <= bid.listing.current_price
          return OpenStruct.new(success?: false, error: "Your bid must be greater than current listing price of #{bid.listing.current_price}")
        end

        if bid.amount <= winning_bid.amount
          logger.info "New bid amount of #{bid.amount} is <= to winning bid amount #{winning_bid.amount}"

          current_price = [winning_bid.amount, BidIncrement.increment(bid.amount)].min
          return OpenStruct.new(
              success?: true,
              current_price: current_price,
              error: "Bad luck, someone has bid a higher price. Your maximum bid must be greater than #{number_to_currency current_price}"
          )
        else
          logger.info "New bid amount of #{bid.amount} is higher than current winning bid amount #{number_to_currency winning_bid.amount}"

          current_price = [bid.amount, BidIncrement.increment(winning_bid.amount)].min
          return OpenStruct.new(
            success?: true,
            current_price: current_price,
            message: "Your bid was successful - you're the highest bidder! The current price is #{number_to_currency current_price}",
            outbid: winning_bid
          )
        end
      end
    end
end
