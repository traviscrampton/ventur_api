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
  validates_presence_of :title, :journal
  belongs_to :journal
  has_one_attached :banner_image
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_one :distance, as: :distanceable, dependent: :destroy

  def distance_to_i
    distance.amount.to_i
  end

  def readable_date
    created_at.strftime("%B %d, %Y")
  end

  def chapter_banner_size
    banner_image.variant(resize: "800x600").processed
  end

  def journal_thumbnail_chapter
    banner_image.variant(resize: "400x300").processed
  end

  def image_url
    if banner_image.attached?
      Rails.application.routes.url_helpers.url_for(journal_thumbnail_chapter)
    else
      ""
    end
  end

  def user
    journal.user
  end

  def banner_image_url
    if banner_image.attached?
      Rails.application.routes.url_helpers.url_for(chapter_banner_size)
    else
      ""
    end
  end
end
