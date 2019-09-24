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

  context "validations" do
    context "for categories" do
      it "allows an empty string" do
        listing = FactoryBot.build(:listing, category:"")
        expect(listing.valid?).to eq(true)
      end

      it "is valid when 'laptop" do
        listing = FactoryBot.build(:listing, category:"laptops")
        expect(listing.valid?).to eq(true)
      end

      it "is valid when 'mobiles" do
        listing = FactoryBot.build(:listing, category:"mobiles")
        expect(listing.valid?).to eq(true)
      end

      it "is valid when 'misc" do
        listing = FactoryBot.build(:listing, category:"misc")
        expect(listing.valid?).to eq(true)
      end

      it "is not valid when 'toaster'" do
        listing = FactoryBot.build(:listing, category:"toaster")
        expect(listing.valid?).to eq(false)
      end
    end

    context "for conditions" do
      it "allows an empty string" do
        listing = FactoryBot.build(:listing, condition:"")
        expect(listing.valid?).to eq(true)
      end

      it "is valid when 'used'" do
        listing = FactoryBot.build(:listing, condition:"used")
        expect(listing.valid?).to eq(true)
      end

      it "is valid when 'new'" do
        listing = FactoryBot.build(:listing, condition:"used")
        expect(listing.valid?).to eq(true)
      end

      it "is not valid when 'a bit dodgy'" do
        listing = FactoryBot.build(:listing, condition:"a bit dodgy")
        expect(listing.valid?).to eq(false)
      end
    end
  end
end
