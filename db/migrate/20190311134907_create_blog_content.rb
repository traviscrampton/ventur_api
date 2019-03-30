class CreateBlogContent < ActiveRecord::Migration[5.2]
  def change
    create_table :editor_blobs do |t|
      t.string :blobable_type
      t.integer :blobable_id
      t.jsonb :draft_content, default: {}
      t.jsonb :final_content, default: {}
      t.timestamps
    end
  end
end
