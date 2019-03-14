class EditorBlobEditor
  require 'yajl'

  attr_accessor(
    :editor_blob,
    :new_images,
    :deleted_ids,
    :draft_content,
    :parser
  )

  def initialize(editor_blob, params, files)
    @editor_blob = editor_blob
    @new_images = files
    @deleted_ids = params[:deletedIds]
    @draft_content = params[:content]
  end

  def call
    upload_new_images
    delete_images
    update_editor_blob
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

  def large_img_uri(img)
    img_size = img.variant(resize: '1000x800').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end

  def delete_images
    # this could be removed completely
    return unless deleted_ids

    @deleted_ids.each { |id| editor_blob.images.find(id).purge_later }
  end

  def update_editor_blob
    editor_blob.update(draft_content: @draft_content)
  end
end
