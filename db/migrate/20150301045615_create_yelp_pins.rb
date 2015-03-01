class CreateYelpPins < ActiveRecord::Migration
  def change
    create_table :yelp_pins do |t|

    	t.string :title
    	t.string :latitude
    	t.string :longitude
    	t.integer :rating
    	t.integer :city_id

      t.timestamps null: false
    end
  end
end