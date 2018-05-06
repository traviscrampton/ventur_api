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

  has_attached_file :avatar, styles: { small: "180x180>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :background_image, styles: { banner: "950x500>" }
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
end
