require 'rails_helper'

RSpec.feature "UserGetsOutbid", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end

  scenario 'placing a maximum bid above the current price where the winning bid has a higher max amount' do
    @listing = FactoryBot.create(:listing, starting_price: 500, current_price: 500)
    @bid1 = FactoryBot.create(:bid, amount: 1000, listing: @listing)

    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    fill_in 'Your Maximum Bid', with: '600'
    click_button 'Place bid'

    expect(page).to have_content(
      "Bad luck, someone has bid a higher price. Your maximum bid must be greater than £620.00"
    )
    expect(@listing.reload.current_price).to eq(620)
    expect(@listing.winning_bid.amount).to eq(1000)
  end

  scenario 'placing a maximum bid the same as an existing maximum bid' do
    @listing = FactoryBot.create(:listing, starting_price: 500, current_price: 500)
    @bid1 = FactoryBot.create(:bid, amount: 1000, listing: @listing)

    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    fill_in 'Your Maximum Bid', with: '1000'
    click_button 'Place bid'

    expect(page).to have_content(
      "Bad luck, someone has bid a higher price. Your maximum bid must be greater than £1,000.00"
    )
    expect(@listing.reload.current_price).to eq(1000)
    expect(@listing.winning_bid.amount).to eq(1000)
  end

end
