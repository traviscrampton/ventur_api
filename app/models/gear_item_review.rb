class GearItemReview < ActiveRecord::Base
  validates_presence_of :gear_item, :rating, :user

  has_many :gear_item_reviews_journals
  has_many :journals, through: :gear_item_reviews_journals
  belongs_to :user
  belongs_to :gear_item
  has_many :pros_cons
end