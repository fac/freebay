class HomeController < ApplicationController
  before_action :require_login

  def index
    @listings = Listing.all
    @listings = @listings.where(condition: params[:condition]) if (params[:condition] && params[:condition] != "all")
    @listings = @listings.where(category: params[:category]) if (params[:category] && params[:category] != "all")
    @listings = @listings.active.order(:end_time)
  end
end
