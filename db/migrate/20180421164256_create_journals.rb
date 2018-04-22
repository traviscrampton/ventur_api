class CreateJournals < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_infos do |t|
      t.integer :user_id
      t.attachment :avatar
      t.attachment :background_image
      t.text :bio
      t.timestamps
    end

    create_table :journals do |t|
      t.integer :user_id
      t.string :slug
      t.string :title
      t.text :description
      t.integer :status
      t.attachment :banner_image
      t.timestamps
    end

    create_table :chapters do |t|
      t.integer :journal_id
      t.string :title
      t.string :slug
      t.text :description
      t.attachment :image
      t.timestamps
    end

    create_table :followings do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.timestamps
    end

    create_table :distances do |t|
      t.integer :distanceable_id
      t.string :distanceable_type
      t.decimal :amount, precision: 8, scale: 2
      t.timestamps
    end

    create_table :tags do |t|
      t.string :title
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.timestamps
    end

    create_table :favorites do |t|
      t.integer :user_id
      t.integer :favoriteable_id
      t.string :favoriteable_type
      t.timestamps
    end

    create_table :gear_lists do |t|
      t.integer :journal_id
      t.integer :gear_item_id
      t.timestamps
    end

    create_table :gear_items do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.decimal :donated, precision: 8, scale: 2
      t.attachment :product_image
      t.timestamps
    end

    create_table :reviews do |t|
      t.integer :user_id
      t.integer :gear_item_id
      t.text :content
      t.timestamps
    end
  end
end
