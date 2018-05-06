# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  gear_item_id :integer
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Review < ActiveRecord::Base
  validates_presence_of :user, :gear_item, :content

  belongs_to :gear_item
  belongs_to :user
end
