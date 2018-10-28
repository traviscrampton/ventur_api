class AddContentToGearItems < ActiveRecord::Migration[5.2]
  def change
    add_column :gear_items, :content, :jsonb
    add_column :gear_items, :user_id, :integer
  end
end
