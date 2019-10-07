require 'rails_helper'

RSpec.describe Admin::ListingsController, type: :controller do
  context "when not logged in" do
    it 'redirects to login' do
      listing = FactoryBot.create(:listing)

      get :show, params: {id: listing.id}

      assert_redirected_to sign_in_path
    end
  end

  context "when logged in as a non-admin user" do
    before do
      @user = FactoryBot.create(:user, admin: false)
      sign_in_as @user
    end

    describe 'GET #index' do
      it 'renders the listing' do
        listing = FactoryBot.create(:listing)

        get :show, params: {id: listing.id}

        assert_redirected_to root_path
      end
    end
  end

  context "when logged in as an admin user" do
    before do
      @user = FactoryBot.create(:user)
      sign_in_as @user
    end

    describe 'GET #index' do
      it 'renders the listing' do
        listing = FactoryBot.create(:listing)

        get :show, params: {id: listing.id}

        assert_response :success
      end
    end
  end
end
