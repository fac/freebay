class HomeController < ApplicationController
  before_action :require_login

  def index
    @auctions = Auction.all
  end
end
