namespace :port_over do
  desc 'port over content to editor blobs'
  task chapter_to_editor_blob: :environment do
    # add comments and then add a transaction
    ActiveRecord::Base.transaction do
      p 'begin creating the editor blobs'
      Chapter.all.each do |chapter|
        EditorBlob.create(blobable_type: chapter.class.to_s,
                          blobable_id: chapter.id,
                          draft_content: chapter.content,
                          final_content: chapter.content)
        p "success creating chaper #{chapter.id}'s blob"
      end
      p 'all done porting editor_blobs'
    end
  end

  desc 'port over chapter images to editor_blobs'
  task blog_images_to_editor_blob: :environment do
    ActiveRecord::Base.transaction do
      p 'begin porting over the images'
      Chapter.all.each do |chapter|
        p "looking for images for chapter #{chapter.id}"
        chapter.blog_images.each do |blog_image|
          blog_image.update(name: 'images',
                            record_type: chapter.editor_blob.class.to_s,
                            record_id: chapter.editor_blob.id)
          p "blob image #{blog_image.id}
            now beings to #{blog_image.record_type}"
        end
      end
      p 'all done porting images'
    end
  end
end
