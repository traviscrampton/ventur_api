class AddOfflineToChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :offline, :boolean, default: false 
  end
end
