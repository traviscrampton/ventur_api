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
  validates_presence_of :title, :journal
  belongs_to :journal
  has_attached_file :image, styles: { banner: "960x550>", card: "460x215>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_one :distance, as: :distanceable, dependent: :destroy

  def distance_to_i
    distance.amount.to_i
  end

  def readable_date
    created_at.strftime("%B %d, %Y")
  end

  def image_url
    "http://localhost:3000" + image.url(:card)
  end
end
