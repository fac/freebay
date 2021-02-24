class HomeController < ApplicationController

  before_action :filter_params

  def index
    @listings = Listing.all
    @listings = @listings.where(condition: params[:condition]) unless params[:condition] == "all"
    @listings = @listings.where(category: params[:category]) unless params[:category] == "all"
    @listings = @listings.active.order(:end_time)
  end

  private

    def filter_params
      params[:condition] = "all" unless Listing::CONDITION.include?(params[:condition])
      params[:category] = "all" unless Listing::CATEGORIES.include?(params[:category])
    end
end
