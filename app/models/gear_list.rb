# == Schema Information
#
# Table name: gear_lists
#
#  id           :integer          not null, primary key
#  journal_id   :integer
#  gear_item_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class GearList < ActiveRecord::Base
  validates_presence_of :journal, :gear_item

  belongs_to :journal
  belongs_to :gear_item
end
