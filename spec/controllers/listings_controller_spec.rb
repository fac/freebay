require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

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
