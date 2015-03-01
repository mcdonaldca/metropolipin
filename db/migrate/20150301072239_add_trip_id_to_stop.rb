class AddTripIdToStop < ActiveRecord::Migration
  def change
  	add_column :stops, :trip_id, :integer
  end
end
