class CreateChapter < ChapterForm
  attr_accessor(
    :journal,
    :chapter,
    :params
  )

  def initialize(params)
    super
    @journal = Journal.find(params[:journalId])
    @chapter = @journal.chapters.new(non_image_params)
  end

  def call
    if chapter.save
      create_additional_records
      handle_image_upload
    end

    chapter
  end

  private

  def create_additional_records
    create_chapter_distance
    create_editor_blob
  end

  def create_chapter_distance
    chapter.create_distance(params[:distance])
  end

  def create_editor_blob
    chapter.create_editor_blob
  end
end
