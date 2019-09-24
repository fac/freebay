class AddCurrentPriceToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :current_price, :decimal
  end
end
