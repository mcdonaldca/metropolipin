class UpdatePins < ActiveRecord::Migration
  def change
  	  add_column :pins, :title, :string
  	  add_column :pins, :latitude, :string
  	  add_column :pins, :longitude, :string
    	add_column :pins, :city_id, :integer
  end
end
