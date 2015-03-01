class ChangeNameToTitle < ActiveRecord::Migration
  def change
  	remove_column :stops, :name
  	add_column :stops, :title, :string
  end
end
