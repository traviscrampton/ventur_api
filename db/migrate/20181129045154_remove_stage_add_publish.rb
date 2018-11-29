class RemoveStageAddPublish < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :published, :boolean, default: false
    remove_column :chapters, :stage
  end
end
