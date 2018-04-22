class Following < ActiveRecord::Base
  # t.integer "follower_id"
  # t.integer "followed_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :follower, :followed

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
