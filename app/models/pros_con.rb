class ProsCon < ActiveRecord::Base

  belongs_to :gear_item_review, dependent: :destroy
  validates_presence_of :gear_item_review, :text
end