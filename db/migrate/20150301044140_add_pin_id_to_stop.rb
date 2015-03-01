class AddPinIdToStop < ActiveRecord::Migration
  def change
  	add_column :stops, :pin_id, :integer
  end
end
