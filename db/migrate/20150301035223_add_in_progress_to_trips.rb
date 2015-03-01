class AddInProgressToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :completed, :integer
  end
end
