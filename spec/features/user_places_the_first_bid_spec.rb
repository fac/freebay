require 'rails_helper'

RSpec.feature "UserPlacesTheFirstBid", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @listing = FactoryBot.create(:listing, starting_price: 500, current_price: nil)
  end

  scenario 'placing the first bid at the starting price' do
    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).to have_content("You're the first bidder – don't hold back!")
    fill_in 'Your Maximum Bid', with: '500'
    click_button 'Place bid'

    expect(page).to have_content("Your bid was successful - you're the highest bidder!")
    expect(@listing.reload.current_price).to eq(500)
    expect(@listing.winning_bid.amount).to eq(500)
  end

  scenario 'placing the first bid below the starting price' do
    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).to have_content("You're the first bidder – don't hold back!")

    fill_in 'Your Maximum Bid', with: @listing.starting_price - 1
    click_button 'Place bid'

    expect(page).to have_content("Amount cannot be lower than the starting price of")
  end

  scenario 'placing the first bid with an amount higher than the starting price' do
    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).to have_content("You're the first bidder – don't hold back!")

    fill_in 'Your Maximum Bid', with: 1000
    click_button 'Place bid'

    expect(page).to have_content("Your bid was successful - you're the highest bidder!")
    expect(@listing.reload.current_price).to eq(500)
    expect(@listing.winning_bid.amount).to eq(1000)
  end
end
