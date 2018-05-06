# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  validates_presence_of :title
  has_many :taggings
  has_many :journals, :through => :taggings, :source => :taggable,
    :source_type => 'Journal'
end
