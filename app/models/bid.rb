class Bid < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validate :amount_cannot_be_lower_than_current_listing_price, unless: ->(bid) { bid.amount.blank? }
  validate :amount_must_be_greater_than_the_starting_price, unless: ->(bid) { bid.amount.blank? }

  def amount_cannot_be_lower_than_current_listing_price
    return if listing.bids.empty?
    if listing.current_price && amount <= listing.current_price
      errors.add(:amount, "must be greater than #{listing.current_price}")
    end
  end

  def amount_must_be_greater_than_the_starting_price
    if listing.bids.empty? && amount < listing.starting_price
      errors.add(:amount, "cannot be lower than the starting price of #{listing.starting_price}")
    end
  end

  def winning?
    self.id == listing.bids.order("amount DESC").first.id
  end
end
