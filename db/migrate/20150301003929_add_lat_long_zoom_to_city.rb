class AddLatLongZoomToCity < ActiveRecord::Migration
  def change
  	add_column :cities, :latitude, :string
  	add_column :cities, :longitude, :string
  	add_column :cities, :zoom, :string
  end
end
