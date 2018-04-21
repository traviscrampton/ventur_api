class Review < ActiveRecord::Base
  # t.integer "user_id"
  # t.integer "gear_item_id"
  # t.text "content"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :user, :gear_item, :content

  belongs_to :gear_list
  belongs_to :user
end
