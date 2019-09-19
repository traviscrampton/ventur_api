class GearItem < ActiveRecord::Base
  has_many :gear_item_reviews
  has_many :users, through: :gear_item_reviews
  
  validates_presence_of :name  

  def affiliate_url
    affiliate_link
  end
end
