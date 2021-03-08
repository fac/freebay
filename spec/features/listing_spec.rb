require 'rails_helper'

RSpec.feature "UserViewsListing", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @listing = FactoryBot.create(:listing)
  end

  scenario 'user logs in and views listing' do
    visit root_path(as: @user)

    visit listing_path(@listing)

    expect(page).to have_content(@listing.title)
    expect(page).to have_content(@listing.description)

    expect(page).to have_link("Bid now")

    # make sure the card is displayed
    expect(page).to have_css 'div.card-body > h5', text: @listing.title
  end
end
