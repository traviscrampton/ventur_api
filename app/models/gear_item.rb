# == Schema Information
#
# Table name: gear_items
#
#  id                         :integer          not null, primary key
#  title                      :string
#  price                      :decimal(8, 2)
#  donated                    :decimal(8, 2)
#  product_image_file_name    :string
#  product_image_content_type :string
#  product_image_file_size    :integer
#  product_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class GearItem < ActiveRecord::Base
  # validates_presence_of :title, :price
  has_one_attached :product_image
  has_many_attached :content_images
  belongs_to :user
  has_many :journals, through: :gear_lists
  has_many :reviews, dependent: :destroy

  def price_to_i
    price.to_i
  end

  def donated_to_i
    donated.to_i
  end

  def product_image_thumbnail
    product_image.variant(resize: "400x300").processed
  end

def product_image_url
    if product_image.attached?
      Rails.application.routes.url_helpers.url_for(product_image_thumbnail)
    else
      ""
    end
  end
end
