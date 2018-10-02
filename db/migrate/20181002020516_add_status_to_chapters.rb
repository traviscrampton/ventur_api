class AddStatusToChapters < ActiveRecord::Migration[5.2]
  def change
  	add_column :chapters, :stage, :integer, default: 0 
  end
end
