class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|

    	t.string :title
    	t.string :lat
    	t.string :long

      t.timestamps null: false
    end
  end
end
