class ProfileInfo < ActiveRecord::Base
  # t.integer "user_id"
  # t.string "avatar_file_name"
  # t.string "avatar_content_type"
  # t.integer "avatar_file_size"
  # t.datetime "avatar_updated_at"
  # t.string "background_image_file_name"
  # t.string "background_image_content_type"
  # t.integer "background_image_file_size"
  # t.datetime "background_image_updated_at"
  # t.text "bio"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  belongs_to :user

	has_attached_file :avatar, styles: { small: "180x180>" }
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	
	has_attached_file :background_image, styles: { banner: "950x500>" }
	validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
end
