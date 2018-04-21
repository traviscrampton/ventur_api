class GearItem < ActiveRecord::Base
  # might have to come back to this one.

  # t.string "title"
  # t.decimal "price", precision: 8, scale: 2
  # t.decimal "donated", precision: 8, scale: 2
  # t.string "product_image_file_name"
  # t.string "product_image_content_type"
  # t.integer "product_image_file_size"
  # t.datetime "product_image_updated_at"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :title, :price

  has_many :journals, through: :gear_lists
  has_many :reviews, dependent: :destroy
end
