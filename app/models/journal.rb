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
  validates_presence_of :user, :status, :stage
  has_attached_file :banner_image, styles: { banner: "960x550>", card: "460x215>" }
  validates_attachment_content_type :banner_image, content_type: /\Aimage\/.*\z/

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
    if distance.amount
      distance.amount.to_i
    else
      0 
    end
  end

  def gear_item_count
    gear_items.count
  end

  def banner_image_url
    "http://localhost:3000" + banner_image.url(:card)
  end

  def calculate_total_distance
    chapters.map(&:distance).pluck(:amount).inject(0, &:+)
  end

  def gear_item_count
    gear_items.count
  end
end
