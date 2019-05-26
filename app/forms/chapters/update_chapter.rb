class UpdateChapter < ChapterForm
  attr_accessor(
    :chapter,
    :params
  )

  def initialize(params)
    super
    @chapter = Chapter.find(params[:id])
  end

  def call
    if chapter.update(non_image_params)
      handle_distance_update
      handle_image_upload
    end

    chapter
  end

  private

  def handle_distance_update
    return unless params[:distance]
    
    chapter.distance.persist_distance_amount(params[:distance].to_f)
    chapter.update_total_distance
  end
end
