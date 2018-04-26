class User < ActiveRecord::Base
  # t.string "email", default: "", null: false
  # t.string "encrypted_password", default: "", null: false
  # t.string "first_name"
  # t.string "last_name"
  # t.string "reset_password_token"
  # t.datetime "reset_password_sent_at"
  # t.datetime "remember_created_at"
  # t.integer "sign_in_count", default: 0, null: false
  # t.datetime "current_sign_in_at"
  # t.datetime "last_sign_in_at"
  # t.string "current_sign_in_ip"
  # t.string "last_sign_in_ip"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.index ["email"], name: "index_users_on_email", unique: true
  # t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :journals, dependent: :destroy
  has_one :profile_info, dependent: :destroy
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :favorites

  def generate_jwt
   JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
                Rails.application.secrets.secret_key_base)
  end
	
	def avatar_image_url 
		profile_info.avatar.url(:small)
	end
	
	def banner_image_url
		profile_info.background_image.url(:banner)
	end
	
	def bio 
		profile_info.bio
	end
end
