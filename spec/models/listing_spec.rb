require 'rails_helper'

RSpec.describe Listing, type: :model do

  context "with an end time" do
    it "must be considered active" do
      listing = FactoryBot.build(:listing, end_time: Time.now + 1.day)
      expect(listing.active?).to eq(true)
    end

    it "must have ended if the end time is in the past" do
      listing = FactoryBot.build(:listing, end_time: Time.now - 1.day)
      expect(listing.ended?).to eq(true)
    end

    it "must not have ended if the end time is in the future" do
      listing = FactoryBot.build(:listing, end_time: Time.now + 1.day)
      expect(listing.ended?).to eq(false)
    end
  end

  context "without an end time" do
    it "must not be considered active" do
      listing = FactoryBot.build(:listing, end_time: nil)
      expect(listing.active?).to eq(false)
    end

    it "must not have ended" do
      listing = FactoryBot.build(:listing, end_time: nil)
      expect(listing.ended?).to eq(false)
    end
  end

  it "must return the bid with the highest amount as the winning bid" do
    listing = FactoryBot.create(:listing)

    bid1 = FactoryBot.create(:bid, amount: 600, listing: listing)
    bid2 = FactoryBot.create(:bid, amount: 800, listing: listing)
    bid3 = FactoryBot.create(:bid, amount: 1600, listing: listing)

    expect(listing.winning_bid).to eq(bid3)
  end
end
