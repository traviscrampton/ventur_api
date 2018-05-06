# == Schema Information
#
# Table name: distances
#
#  id                :integer          not null, primary key
#  distanceable_id   :integer
#  distanceable_type :string
#  amount            :decimal(8, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Distance < ActiveRecord::Base
  validates_presence_of :distanceable, :amount
  belongs_to :distanceable, polymorphic: true
end
