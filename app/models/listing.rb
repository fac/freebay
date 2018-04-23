class Listing < ApplicationRecord
  has_many :bids, dependent: :destroy

  has_attached_file :image,
      styles: { medium: "300x300#", thumb: "100x100>" },
      default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image,
      content_type: /\Aimage\/.*\z/

  scope :active, -> { where("end_time IS NOT NULL").where("is_archived <> TRUE") }

  def winning_bid_amount
    bids.maximum(:amount) || 0
  end

  def winning_bid
    bids.order("amount DESC").first
  end

  def ended?
    end_time.present? && end_time < Time.zone.now
  end

  def active?
    end_time.present? && !is_archived?
  end
end
