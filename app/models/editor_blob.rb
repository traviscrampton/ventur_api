class EditorBlob < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :blobable, polymorphic: true
  has_many_attached :images

  def large_image_url(image)
    img_size = image.variant(resize: "1000x800").processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end
end
