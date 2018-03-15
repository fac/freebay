class HomeController < ApplicationController
  before_action :require_login

  def index
    @listings = Listing.active.order(:end_time).all
  end
end
