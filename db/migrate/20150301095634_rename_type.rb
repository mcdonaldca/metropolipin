class RenameType < ActiveRecord::Migration
  def change
  	remove_column :stops, :type
  	add_column :stops, :pin_type, :string
  end
end
