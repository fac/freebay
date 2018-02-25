class AddStartAmountToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :starting_price, :decimal, null: false, default: 0
  end
end
