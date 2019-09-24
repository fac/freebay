require 'rails_helper'

RSpec.describe BidIncrement, type: :model do
  it 'should increment correctly' do
    expect(BidIncrement.increment(0.99)).to eq(1.04)
    expect(BidIncrement.increment(2.00)).to eq(2.20)
    expect(BidIncrement.increment(14.99)).to eq(15.49)
    expect(BidIncrement.increment(15)).to eq(16.00)
    expect(BidIncrement.increment(65)).to eq(67)
    expect(BidIncrement.increment(299)).to eq(304)
    expect(BidIncrement.increment(500)).to eq(510)
    expect(BidIncrement.increment(1400)).to eq(1420)
    expect(BidIncrement.increment(1500)).to eq(1550)
    expect(BidIncrement.increment(3000)).to eq(3100)
  end
end