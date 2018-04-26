class Journal < ActiveRecord::Base
  # t.integer "user_id"
  # t.string "slug"
  # t.string "title"
  # t.text "description"
  # t.string "banner_image_file_name"
  # t.string "banner_image_content_type"
  # t.integer "banner_image_file_size"
  # t.datetime "banner_image_updated_at"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :title, :slug, :description, :user
  has_attached_file :banner_image, styles: { banner: "960x550>", card: "460x215>" }
  validates_attachment_content_type :banner_image, content_type: /\Aimage\/.*\z/
	
	enum status: [:active, :paused, :completed]

  belongs_to :user
  has_one :distance, as: :distanceable, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :gear_lists
  has_many :gear_items, through: :gear_lists
  has_many :favorites, as: :favoriteable, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def update_total_distance
    distance_array = chapters.map(&:distance).pluck(:amount)
    total_distance = distance_array.inject(0, &:+)
    distance.update(amount: total_distance)
  end
	
	def gear_item_count
		gear_items.count
	end
end
