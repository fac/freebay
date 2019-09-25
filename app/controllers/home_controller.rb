class HomeController < ApplicationController
  before_action :require_login

  def index
    if params[:condition] == "all"
      params.delete(:condition)
    end

    if params[:category] == "all"
      params.delete(:category)
    end

    @listings = Listing.all
    @listings = @listings.where(condition: params[:condition]) if params[:condition]
    @listings = @listings.where(category: params[:category]) if params[:category]
    @listings.active.order(:end_time)
  end
end
