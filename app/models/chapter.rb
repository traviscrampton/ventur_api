# == Schema Information
#
# Table name: chapters
#
#  id                 :integer          not null, primary key
#  journal_id         :integer
#  title              :string
#  slug               :string
#  description        :text
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
  has_one_attached :image
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_one :distance, as: :distanceable, dependent: :destroy

  def distance_to_i
    distance.amount.to_i
  end

  def readable_date
    created_at.strftime("%B %d, %Y")
  end

  def journal_thumbnail_chapter
    image.variant(resize: "200x200").processed
  end

  def image_url
    Rails.application.routes.url_helpers.url_for(journal_thumbnail_chapter)
  end
end
