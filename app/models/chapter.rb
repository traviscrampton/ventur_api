class Chapter < ActiveRecord::Base
  # t.integer "journal_id"
  # t.string "title"
  # t.string "slug"
  # t.string "image_file_name"
  # t.string "image_content_type"
  # t.integer "image_file_size"
  # t.datetime "image_updated_at"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  validates_presence_of :title, :journal, :slug
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
