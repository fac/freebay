class BidsController < ApplicationController

  before_action :load_listing, only: [:new, :create]
  before_action :check_status, only: [:new, :create]

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

  def create
    @listing.lock!

    current_winning_bid = @listing.winning_bid

    # don't use `@listing.bids.build` since we don't want `@listing` to be aware of
    # unsaved bids
    @bid = Bid.new bid_params.merge(listing: @listing, user: current_user)
    if @bid.save
      OutbidNotifier.send_outbid_notice(current_winning_bid, @bid).deliver

      flash[:notice] = "Your bid was successful - you're the highest bidder!"
      redirect_to listing_path(@listing)
    else
      flash[:error] = @bid.errors.full_messages.to_sentence
      render 'new'
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
end
