# == Schema Information
#
# Table name: favorites
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  favoriteable_id   :integer
#  favoriteable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Favorite < ActiveRecord::Base
  validates_presence_of :user, :favoriteable
  belongs_to :user
  belongs_to :favoriteable, polymorphic: true
end
