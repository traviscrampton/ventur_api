# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  include ApplicationHelper
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :journals, dependent: :destroy
  has_one :profile_info, dependent: :destroy
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :favorites

  def generate_jwt
    JWT.encode({ id: id,
                 exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def avatar_image_url
    # "http://localhost:3000" + profile_info.avatar.url(:small)
    "http://#{get_ip_address}:3000" + profile_info.avatar.url(:small)
  end

  def banner_image_url
    # "http://localhost:3000" + profile_info.background_image.url(:banner)
    "http://#{get_ip_address}:3000" + profile_info.background_image.url(:banner)
  end

  def bio
    profile_info.bio
  end

  def total_distance
    journals.map(&:total_distance).inject(0, &:+)
  end

  def journal_count
    journals.count
  end

  def full_name
    first_name + " " + last_name
  end
end
