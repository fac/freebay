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
    current_winning_bid = @bid.listing.winning_bid

    if result = @bid.save
      OutbidNotifier.send_outbid_notice(current_winning_bid, @bid).deliver
    end
    OpenStruct.new(success?: result, bid: @bid)
  end
end
