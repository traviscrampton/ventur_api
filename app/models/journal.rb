# == Schema Information
#
# Table name: journals
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  slug                      :string
#  title                     :string
#  description               :text
#  status                    :integer
#  stage                     :integer
#  banner_image_file_name    :string
#  banner_image_content_type :string
#  banner_image_file_size    :integer
#  banner_image_updated_at   :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Journal < ActiveRecord::Base
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  validates_presence_of :user, :status, :stage
  has_one_attached :banner_image

  validates :title, presence: { message: "Title can't be blank if you want to publish journal"}, if: -> { published? }
  validates :description, presence: { message: "Description can't be blank if you want to publish journal" }, if: -> { published? }

  enum status: [:not_started, :active, :paused, :completed]
  enum stage: [:draft, :published]

  belongs_to :user
  has_one :distance, as: :distanceable, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :gear_item_reviews
  has_many :gear_items, through: :gear_item_reviews
  has_one :editor_blob, as: :blobable, dependent: :destroy
  has_one :cycle_route, as: :routable
  has_many :included_countries
  has_many :countries, through: :included_countries
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :journal_follows
  has_many :following_users, source: :user, through: :journal_follows


  def published?
    stage == "published"
  end

  def update_total_distance
    distance.persist_distance_amount(calculate_total_distance)
  end

  def total_distance
    if distance
      distance.amount
    else
      0 
    end
  end

  def gear_item_count
    gear_items.count
  end

  def card_size
    banner_image.variant(resize: "600x400").processed
  end

  def mini_size
    banner_image.variant(resize: "300x300").processed
  end

  def web_banner_size
    banner_image.variant(resize: "1000x800").processed
  end

  def thumbnail_image_size
    banner_image.variant(resize: "50x33").processed
  end

  def follower_count
    journal_follows.count
  end

  def card_banner_image_url
    banner_image.attached? ? Rails.application.routes.url_helpers.url_for(card_size) : ""
  end

  def mini_banner_image_url
    banner_image.attached? ? Rails.application.routes.url_helpers.url_for(mini_size) : ""
  end

  def web_banner_image_url
    banner_image.attached? ? Rails.application.routes.url_helpers.url_for(web_banner_size) : ""
  end

  def thumbnail_image_url
    banner_image.attached? ? Rails.application.routes.url_helpers.url_for(thumbnail_image_size) : ""
  end

  def calculate_total_distance
    pluck_attribute = (distance.distance_type + "_amount").to_sym

    chapters.map(&:distance).pluck(pluck_attribute).inject(0, &:+)
  end

  def is_following(user_id)
    return false unless user_id
    
    journal_follows.map(&:user_id).include?(user_id)
  end

  def all_chapters
    chapters.sort_by {|chapter| chapter.created_on }
  end

  def published_chapters
    chapters.where(published: true).sort_by {|chapter| chapter.created_on }
  end

  def gear_item_count
    gear_items.count
  end
end
