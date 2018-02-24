class HomeController < ApplicationController
  before_action :require_login

  def index
    @listings = Listing.all
  end
end
