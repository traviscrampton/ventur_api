class GearItem < ActiveRecord::Base
  has_many :gear_item_reviews
  has_many :journals, through: :gear_item_reviews
  
  validates_presence_of :name
end
