class EditorBlobEditor
  require 'yajl'

  attr_accessor(
    :editor_blob,
    :new_images,
    :deleted_ids,
    :draft_content
  )

  def initialize(editor_blob, params)
    @editor_blob = editor_blob
    @new_images = params[:newImages]
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

    uploaded_images = new_images.map do |img|
      editor_blob.images.attach(img)
      # may have to return the actual blob
    end

    uploaded_images_to_draft_content(uploaded_images)
  end

  def uploaded_images_to_draft_content(uploaded_images)
    parser = Yajl::Parser.new
    parsed_content = parser.parse(draft_content)

    updated_editor_content = parsed_content.map do |entry|
      return entry unless img_entry_needs_update?
      
      image = uploaded_images.find { |img| img.filename == entry["filename"] }
      entry['id'] = image.id
      entry['uri'] = large_img_uri(image)
      entry['lowResUri'] = small_img_uri(image)
      entry
    end

    draft_content = updated_editor_content.to_json
  end

  def img_entry_needs_update?(entry)
    entry['type'] == 'image' && entry['id'].nil?
  end

  def small_img_uri(img)
    img_size = img.variant(resize: '500x400').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end

  def large_img_uri(img)
    img_size = img.variant(resize: '1000x800').processed
    Rails.application.routes.url_helpers.url_for(img_size)
  end

  def delete_images
    return unless deleted_ids

    @deleted_ids.each { |id| editor_blob.images.find(id).purge_later }
  end

  def update_editor_blob
    blob_editor.update(draft_content: draft_content)
  end
end
