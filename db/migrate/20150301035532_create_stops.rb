class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|

    	t.string :name
    	t.string :latitude
    	t.string :longitude
    	t.datetime :time
    	t.integer :rating

      t.timestamps null: false
    end
  end
end
