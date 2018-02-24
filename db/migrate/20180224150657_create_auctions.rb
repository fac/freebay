class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.integer :duration, null: false
      t.integer :item_id, null: false

      t.timestamps
    end

    add_foreign_key :auctions, :items
  end
end
