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
  has_one_attached :avatar
  has_many :gear_items
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :favorites
  has_many :journal_follows
  has_many :followed_journals, source: :journal, through: :journal_follows

  def generate_jwt
    JWT.encode({  id: id,
                  exp: 365.days.from_now.to_i },
                  Rails.application.secrets.secret_key_base)
  end

  def avatar_image_url
    if avatar.attached?
      Rails.application.routes.url_helpers.url_for(profile_image_avatar)
    else 
      ""
    end
  end

  def profile_image_avatar
    return self.avatar.variant(resize: "100x100").processed
  end

  def banner_image_url
    return ""
  end

  def total_distance
    journals.map(&:total_distance).inject(0, &:+)
  end

  def journal_count
    journals.count
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
