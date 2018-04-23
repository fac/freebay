class AddArchivedFlagToListing < ActiveRecord::Migration[5.2]
  def change
    add_column    :listings, :is_archived, :boolean, default: false
  end
end
