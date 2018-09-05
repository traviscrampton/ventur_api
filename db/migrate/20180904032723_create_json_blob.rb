class CreateJsonBlob < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :content, :jsonb
  end
end
