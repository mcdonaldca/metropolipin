class AddTypeToStops < ActiveRecord::Migration
  def change
  	add_column :stops, :type, :string
  end
end
