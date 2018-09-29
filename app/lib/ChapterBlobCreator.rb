class ChapterBlobCreator

  attr_accessor :chapter, :params

  def initialize
    @saveable_images = []
    @saved_filenames = chapter.content_images_filenames
  end

  def persist_images    



    chapter.entries.each do |entry|
      next if entry.type == "text"
      next if @saved_images.includes(entry.filename)
      remove_from_temp_array(entry) 
    end


  end

  def add_to_persisted_images(entry)
    @saveable_images.push(entry)
  end

  def remove_from_temp_array(entry)
    @saved_filenames.remove(entry)
  end
end

