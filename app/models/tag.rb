class Tag < ActiveRecord::Base
  # t.string "title"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :title
  has_many :taggings
  has_many :journals, :through => :taggings, :source => :taggable,
           :source_type => 'Journal'
end
