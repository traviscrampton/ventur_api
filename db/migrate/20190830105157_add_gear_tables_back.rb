class AddGearTablesBack < ActiveRecord::Migration[5.2]
  def change
    create_table :gear_items do |t|
      t.string :name, default: ""
      t.text :description, default: ""
      t.string :image_url, default: ""
      t.string :affiliate_link, default: ""
      t.boolean :verified, default: false
      t.timestamps
    end

    create_table :gear_item_reviews do |t|
      t.integer :user_id
      t.integer :gear_item_id
      t.text :review, default: ""
      t.jsonb :images, default: []
      t.float :rating
      t.timestamps
    end

    create_table :gear_item_reviews_journals do |t|
      t.integer :gear_item_review_id
      t.integer :journal_id
      t.timestamps
    end

    create_table :pros_cons do |t|
      t.integer :gear_item_review_id
      t.boolean :is_pro, default: true
      t.text :text, default: ""
      t.timestamps
    end
  end
end
