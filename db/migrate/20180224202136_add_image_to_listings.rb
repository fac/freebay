class AddImageToListings < ActiveRecord::Migration[5.2]
  def change
    add_attachment :listings, :image
  end
end
