# == Schema Information
#
# Table name: chapters
#
#  id                 :integer          not null, primary key
#  journal_id         :integer
#  title              :string
#  slug               :string
#  description        :text
#  content            :jsonb
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Chapter < ActiveRecord::Base
  include ApplicationHelper

  validates_presence_of :journal
  validate :published_validations


  belongs_to :journal
  has_one_attached :banner_image
  has_many_attached :blog_images
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_one :distance, as: :distanceable, dependent: :destroy
  has_one :editor_blob, as: :blobable, dependent: :destroy

  def distance_to_i
    distance.amount.to_i
  end

  def readable_date
    created_on.strftime("%B %d, %Y")
  end

  def created_on
    date || created_at
  end

  def numbered_date
    created_on.to_f * 1000
  end

  def chapter_banner_size
    banner_image.variant(resize: "800x600").processed
  end

  def journal_thumbnail_chapter
    banner_image.variant(resize: "400x300").processed
  end

  def blog_image_count
    editor_blob.images.count
  end

  def image_url
    banner_image.attached? ? get_env_image_url(journal_thumbnail_chapter) : ""    
  end

  def user
    journal.user
  end

  def banner_image_url
    banner_image.attached? ? get_env_image_url(chapter_banner_size) : ""
  end

  def update_total_distance
    journal.update_total_distance
  end

  def get_env_image_url(img_size)
    Rails.env.production? ? img_size.service_url : Rails.application.routes.url_helpers.url_for(img_size)
  end

  def published_validations
    if published && title.blank?
      errors.add(:title, "cannot be blank if chapter is published")
    end
  end
end
