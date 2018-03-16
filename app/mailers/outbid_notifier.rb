class OutbidNotifier < ApplicationMailer

  def send_outbid_notice(previous_winning_bid, new_winning_bid)
    return unless previous_winning_bid.present?

    if previous_winning_bid.user_id != new_winning_bid.user_id
      @user = previous_winning_bid.user
      @previous_winning_bid = previous_winning_bid
      @new_winning_bid = new_winning_bid
      @listing = previous_winning_bid.listing

      mail to: @user.email,
           from: "noreply@freebayapp.com",
           subject: 'FreeBay - You have been outbid!'
    end
  end
end
