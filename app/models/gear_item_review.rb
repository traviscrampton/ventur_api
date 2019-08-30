class GearItemReview < ActiveRecord::Base
  validates_presence_of :journal, :gear_item, :rating

  belongs_to :journal
  belongs_to :gear_item
  has_many :pros_cons
end