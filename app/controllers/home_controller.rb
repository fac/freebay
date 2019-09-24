class HomeController < ApplicationController
  before_action :require_login

  def index
    if params[:condition]
      @listings = Listing.where(condition: params[:condition]).active.order(:end_time).all
    else
      @listings = Listing.active.order(:end_time).all
    end
  end
end
