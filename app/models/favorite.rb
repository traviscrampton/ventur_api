class Favorite < ActiveRecord::Base
  # t.integer "user_id"
  # t.integer "favoriteable_id"
  # t.string "favoriteable_type"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :user, :favoriteable
  belongs_to :user
  belongs_to :favoriteable, polymorphic: true
end
