class AddPublished < ActiveRecord::Migration[5.2]
  def change
    add_column :gear_items, :published, :boolean, default: false
  end
end
