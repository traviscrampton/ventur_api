class Chapter < ActiveRecord::Base
  # t.integer "journal_id"
  # t.string "title"
  # t.string "slug"
  # t.string "image_file_name"
  # t.string "image_content_type"
  # t.integer "image_file_size"
  # t.datetime "image_updated_at"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :title, :journal, :slug
  belongs_to :journal
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_one :distance, as: :distanceable, dependent: :destroy
end
