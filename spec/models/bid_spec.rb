require 'rails_helper'

RSpec.describe Bid, type: :model do

  it "must have a positive amount" do
    bid = FactoryBot.build(:bid, amount: -1)

    expect(bid).to_not be_valid
    expect(bid.errors[:amount]).to include('must be greater than 0')
  end

  it "must have an amount greater than the starting price" do
    bid = FactoryBot.build(:bid)
    bid.amount = bid.listing.starting_price - 1

    expect(bid).to_not be_valid
    expect(bid.errors[:amount]).to include(/cannot be lower than the starting price of/)
  end

  it "must have an amount greater than the current winning price" do
    high_bid = FactoryBot.create(:bid)

    bid = FactoryBot.build(:bid, amount: high_bid.listing.current_price, user: high_bid.user, listing: high_bid.listing)
    expect(bid).to_not be_valid
    expect(bid.errors[:amount]).to include(/must be greater than/)
  end

  it "must be winning if it is the highest bid" do
    bid1 = FactoryBot.create(:bid)
    bid2 = FactoryBot.create(:bid, amount: 600, listing: bid1.listing)

    expect(bid1.winning?).to eq(false)
    expect(bid2.winning?).to eq(true)
  end
end
