class Tagging < ActiveRecord::Base
  # t.integer "tag_id"
  # t.integer "taggable_id"
  # t.string "taggable_type"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :tag, :taggable, :taggable_type
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
