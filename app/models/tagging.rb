# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  taggable_id   :integer
#  taggable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Tagging < ActiveRecord::Base
  validates_presence_of :tag, :taggable, :taggable_type
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
