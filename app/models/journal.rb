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
  has_many :gear_lists
  has_many :gear_items, through: :gear_lists
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings


  def published?
    stage == "published"
  end

  def update_total_distance
    distance.update(amount: calculate_total_distance)
  end

  def total_distance
    if distance
      distance.amount.to_i
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

  def card_banner_image_url
    Rails.application.routes.url_helpers.url_for(card_size)
  end

  def mini_banner_image_url
    Rails.application.routes.url_helpers.url_for(mini_size)
  end

  def web_banner_image_url
    Rails.application.routes.url_helpers.url_for(web_banner_size)
  end

  def calculate_total_distance
    chapters.map(&:distance).pluck(:amount).inject(0, &:+)
  end

  def sorted_chapters
    chapters.sort_by {|chapter| chapter.created_on }
  end

  def gear_item_count
    gear_items.count
  end
end
