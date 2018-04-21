class Distance < ActiveRecord::Base
  # t.integer "distanceable_id"
  # t.string "distanceable_type"
  # t.decimal "amount", precision: 8, scale: 2
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  validates_presence_of :distanceable, :amount
  belongs_to :distanceable, polymorphic: true
end
