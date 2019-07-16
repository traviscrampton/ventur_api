class EditorBlobEditor
  require 'yajl'

  attr_accessor(
    :editor_blob,
    :new_images,
    :draft_content,
    :parser
  )

  def initialize(editor_blob, params, files)
    @editor_blob = editor_blob
    @new_images = files
    @draft_content = params[:content]
  end

  def call
    upload_new_images
    update_editor_blob
    garbage_collection_call
    editor_blob
  end

  private

  def upload_new_images
    return unless new_images

    uploaded_blobs = new_images.map do |img|
      uploaded = editor_blob.images.attach(img)
      uploaded.first.blob
    end

    uploaded_images_to_draft_content(uploaded_blobs)
  end

  def uploaded_images_to_draft_content(uploaded_blobs)
    parser = Yajl::Parser.new
    parsed_content = parser.parse(@draft_content)

    updated_editor_content = parsed_content.map do |entry|
      if img_entry_needs_update?(entry)
        image = uploaded_blobs.find { |blob| blob.filename == entry["filename"] }
        entry['id'] = image.id
        entry['uri'] = large_img_uri(image)
        entry['lowResUri'] = small_img_uri(image)
        entry['thumbnailSource'] = thumbnail_source_uri(image)
      end
      entry
    end

    @draft_content = updated_editor_content.to_json
  end

  def img_entry_needs_update?(entry)
    entry['type'] == 'image' && entry['id'].nil?
  end

  def small_img_uri(img)
    img_size = img.variant(resize: '600x450').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end

  def thumbnail_source_uri(img)
    img_size = img.variant(resize: '50x37').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end

  def large_img_uri(img)
    img_size = img.variant(resize: '1000x800').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end
  
  def update_editor_blob
    editor_blob.update(draft_content: @draft_content)
  end

  def garbage_collection_call
    return unless Rails.env.production? && new_images
    GC.start
  end
end
