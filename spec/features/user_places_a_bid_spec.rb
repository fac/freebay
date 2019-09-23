require 'rails_helper'

RSpec.feature "UserPlacesABid", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @listing = FactoryBot.create(:listing)
  end

  scenario 'placing the first bid above the starting price' do
    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).to have_content("You're the first bidder – don't hold back!")

    fill_in 'Amount', with: '1000'
    click_button 'Place bid'

    expect(page).to have_content("Your bid was successful - you're the highest bidder!")
    expect(@listing.winning_bid.amount).to eq(1000)
  end

  scenario 'placing the first bid below the starting price' do
    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).to have_content("You're the first bidder – don't hold back!")

    fill_in 'Amount', with: @listing.starting_price - 1
    click_button 'Place bid'

    expect(page).to have_content("Amount cannot be lower than the starting price of")
  end

  scenario 'placing a bid that is lower than current highest bid' do
    bid = FactoryBot.create(:bid, listing_id: @listing.id, user_id: @user.id)

    visit new_listing_bid_path(listing_id: @listing.id, as: @user)

    expect(page).not_to have_content("You're the first bidder – don't hold back!")

    fill_in 'Amount', with: '100'
    click_button 'Place bid'

    expect(page).to have_content("Amount must be greater than")
  end
end
