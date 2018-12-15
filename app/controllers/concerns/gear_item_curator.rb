class BlogImageCurator

  attr_accessor :gear_item,  :images

  def initialize(gear_item, images)
    @gear_item = gear_item
    @parsed_entries = JSON.parse(gear_item.content)
    @images = images
    @current_image_ids = gear_item.content_image_blobs.pluck(:id)
  end

  def call
    purge_deleted_images
    persist_new_images
    insert_new_image_urls
  end

  def purge_deleted_images
    image_ids = @parsed_entries.map { |entry| entry["id"] }.compact   

    image_ids.each do |id| 
      if @current_image_ids.include?(id)
        @current_image_ids.delete_at(@current_image_ids.index(id))
      end
    end

    purge_images
  end

  def purge_images
    return if @current_image_ids.empty?

    @current_image_ids.each { |id| @gear_item.content_images.find(id).purge }
  end

  def persist_new_images 
    return if @images.nil?
    
    @images.each { |img| @gear_item.content_images.attach(img) }
  end

  def insert_new_image_urls
    blobs = @gear_item.content_image_blobs
    new_entries_blob = @parsed_entries.map do |entry|
      if entry["type"] == "image" && entry["id"].nil?
        persisted_image = blobs.find { |img|  img.filename == entry["filename"] }
        entry["id"] = persisted_image.id
        entry["uri"] = Rails.application.routes.url_helpers.url_for(persisted_image.variant(resize: "800x600").processed)
      end
      entry
    end

    @gear_item.update(content: new_entries_blob.to_json)
  end
end