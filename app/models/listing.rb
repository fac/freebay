class Listing < ApplicationRecord
  has_many :bids, dependent: :destroy

  has_attached_file :image,
      styles: { medium: "300x300#", thumb: "100x100>" },
      default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image,
      content_type: /\Aimage\/.*\z/

  scope :active, -> { where("end_time IS NOT NULL") }

  def winning_bid
    bids.maximum(:amount) || 0
  end

  def ended?
    end_time.present? && end_time < Time.zone.now
  end

  def active?
    end_time.present?
  end
end
