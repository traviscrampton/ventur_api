class GearItemReviewsJournal < ActiveRecord::Base
  belongs_to :journal 
  belongs_to :gear_item_review

  validates_presence_of :journal, :gear_item_review
end