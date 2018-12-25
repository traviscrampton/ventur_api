class BlogImageCurator

  attr_accessor :chapter,  :images

  def initialize(chapter, images)
    @chapter = chapter
    @parsed_entries = JSON.parse(chapter.content)
    @images = images
    @current_image_ids = chapter.blog_images_blobs.pluck(:id)
  end

  def call
    purge_deleted_images
    persist_new_images
    insert_new_image_urls
    garbage_collection_call
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

    @current_image_ids.each { |id| @chapter.blog_images.find(id).purge }
  end

  def persist_new_images 
    return if @images.nil?
    
    @images.each { |img| @chapter.blog_images.attach(img) }
  end

  def insert_new_image_urls
    blobs = @chapter.blog_images_blobs
    new_entries_blob = @parsed_entries.map do |entry|
      if entry["type"] == "image" && entry["id"].nil?
        persisted_image = blobs.find { |img|  img.filename == entry["filename"] }
        entry["id"] = persisted_image.id
        entry["uri"] = get_persisted_image_url(persisted_image)
      end
      entry
    end

    @chapter.update(content: new_entries_blob.to_json)
  end

  def get_persisted_image_url(persisted_image)
    img_size = persisted_image.variant(resize: "800x600").processed
    Rails.env.production? ? img_size.service_url : Rails.application.routes.url_helpers.url_for(img_size)
  end

  def garbage_collection_call
    return unless Rails.env.production?
    
    GC.start
  end
end