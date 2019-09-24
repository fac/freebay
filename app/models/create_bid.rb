# Service object to encapsulate the logic of creating a bid to make
# BidsController neat and tidy
class CreateBid
  def self.call(*args, &block)
    new(*args, &block).execute
  end

  def initialize(bid)
    @bid = bid
  end

  def execute
    autobid

    @bid
  end

  def autobid
    logger = Rails.logger
    listing = @bid.listing

    winning_bid = listing.winning_bid

    if winning_bid.nil?
      listing.current_price = listing.starting_price
      logger.info "First bid. Setting listing #{listing.id} current price to #{listing.current_price}"
      listing.save! and return
    end

    logger.info "New bid! Current winning bid #{winning_bid.id} amount is #{winning_bid.amount}. Listing current price is #{listing.current_price}"

    if @bid.user_id == winning_bid.user_id
      logger.info "User #{@bid.user_id} trying to increase maximum bid"
      # if this is a new bid by the same user, only accept it if it's higher (i.e. they're increasing their max bid)
      if @bid.amount <= winning_bid.amount
        logger.info "Amount of #{@bid.amount} is not higher than existing max bid of #{winning_bid.amount}"
        @bid.errors.add(:amount, "must be greater than your existing maximum bid of #{winning_bid.amount}")
      end
    else
      if @bid.amount <= listing.current_price
        @bid.errors.add(:amount, "must be greater than current listing price of #{listing.current_price}")
        return
      end

      if @bid.amount <= winning_bid.amount
        logger.info "New bid amount of #{@bid.amount} is <= to winning bid amount #{winning_bid.amount}"

        listing.current_price = [winning_bid.amount, BidIncrement.increment(@bid.amount)].min
        logger.info "Setting current_price to #{listing.current_price}"
        listing.save!

        @bid.errors.add(:amount, "must be greater than #{listing.current_price}")
      else
        logger.info "New bid amount of #{@bid.amount} is higher than current winning bid amount #{winning_bid.amount}"

        listing.current_price = [@bid.amount, BidIncrement.increment(winning_bid.amount)].min
        logger.info "Setting current_price to #{listing.current_price}"
        listing.save!

        # TODO send outbid to winning_bid user
      end
    end
  end
end