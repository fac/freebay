class AddStartAndEndTimeToListing < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :duration
    add_column    :listings, :end_time, :datetime
    rename_column :listings, :started_on, :start_time
  end
end
