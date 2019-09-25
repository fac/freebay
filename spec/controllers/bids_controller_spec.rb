require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in_as @user
  end

  describe 'GET #index' do
    it 'renders the page correctly' do
      listing = FactoryBot.create(:listing)

      get 'index', params: { listing_id: listing.id }

      assert_response :success
    end
  end

  describe 'GET #new' do
    it 'renders the form correctly for an active listing' do
      listing = FactoryBot.create(:listing)

      get :new, params: { listing_id: listing.id }
      assert_response :success
    end

    it 'redirects to the listing show page for an inactive listing' do
      listing = FactoryBot.create(:listing, end_time: nil)

      get :new, params: { listing_id: listing.id }

      expect(response).to redirect_to(listing_path(listing))
      expect(flash[:notice]).to eq("Hold your horses, bidding hasn't started yet! 🐴")
    end
  end

  describe 'PUT #update' do
    it 'should redirect to the listing index page' do
      bid = FactoryBot.create(:bid)

      put :update, params: { listing_id: bid.listing.id, id: bid.id, amount: 500 }

      expect(response).to redirect_to(listing_path(bid.listing))
    end
  end

  describe 'POST #destroy' do
    it 'should redirect to the listing index page' do
      bid = FactoryBot.create(:bid)

      post :destroy, params: { listing_id: bid.listing.id, id: bid.id }

      expect(response).to redirect_to(listing_path(bid.listing))
    end
  end
end
