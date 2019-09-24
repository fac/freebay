require 'rails_helper'

RSpec.describe CreateBid, type: :model do

  # context 'creating the first bid' do
  #   it 'sets the current price of the listing to the starting price' do
  #     listing = FactoryBot.create(:listing, starting_price: 100)
  #     bid = FactoryBot.build(:bid, listing: listing, amount: 500)

  #     expect(listing.current_price).to eq(nil)

  #     result = CreateBid.call(bid)

  #     expect(result.success?).to eq(true)
  #     expect(result.bid.amount).to eq(500)
  #     expect(result.bid.winning?).to eq(true)
  #     expect(listing.current_price).to eq(100)
  #   end
  # end
end