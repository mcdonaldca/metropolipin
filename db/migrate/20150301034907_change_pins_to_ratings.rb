class ChangePinsToRatings < ActiveRecord::Migration
  def change
  	remove_column :pins, :trip_id
  	add_column :ratings, :trip_id, :integer
  end
end
