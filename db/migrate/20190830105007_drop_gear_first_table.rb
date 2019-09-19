class DropGearFirstTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :gear_items
    drop_table :reviews
    drop_table :gear_lists
  end
end
