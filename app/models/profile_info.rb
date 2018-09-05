# == Schema Information
#
# Table name: profile_infos
#
#  id                            :integer          not null, primary key
#  user_id                       :integer
#  avatar_file_name              :string
#  avatar_content_type           :string
#  avatar_file_size              :integer
#  avatar_updated_at             :datetime
#  background_image_file_name    :string
#  background_image_content_type :string
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  bio                           :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

class ProfileInfo < ActiveRecord::Base
  belongs_to :user
  has_one_attached :avatar
  has_one_attached :background_image
end
