class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :listing_id, null: false
      t.integer :user_id, null: false
      t.decimal :amount, null: false

      t.timestamps
    end

    add_foreign_key :bids, :listings
    add_foreign_key :bids, :users
  end
end
