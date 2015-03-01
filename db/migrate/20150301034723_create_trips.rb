class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|

    	t.integer :city_id
    	t.integer :user_id

      t.timestamps null: false
    end

    add_column :pins, :trip_id, :integer
  end
end
