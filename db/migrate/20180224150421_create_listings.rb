class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string  :title, null: false
      t.text    :description, null: false
      t.integer :duration, null: false
      t.decimal :reserve_price
      t.datetime :started_on

      t.timestamps
    end
  end
end
