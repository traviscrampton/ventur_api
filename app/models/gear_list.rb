class GearList < ActiveRecord::Base
  # t.integer "journal_id"
  # t.integer "gear_item_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :journal, :gear_item

  belongs_to :journal
  belongs_to :gear_item
end
