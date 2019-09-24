# See https://www.ebay.co.uk/help/buying/bidding/automatic-bidding?id=4014
class BidIncrement

  def self.increment(price)
    if price < 1
      price + 0.05
    elsif price < 5
      price + 0.20
    elsif price < 15
      price + 0.50
    elsif price < 60
      price + 1.00
    elsif price < 150
      price + 2.00
    elsif price < 300
      price + 5.00
    elsif price < 600
      price + 10.00
    elsif price < 1500
      price + 20.00
    elsif price < 3000
      price + 50.00
    else
      price + 100.00
    end
  end
end