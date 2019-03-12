class ChapterForm
  attr_accessor(
    :chapter,
    :journal,
    :params
  )

  def initialize(params)
    @params = params
  end

  private

  def non_image_params
    params.permit(:title, :description, :published, :offline, :date, :content)
  end

  def handle_image_upload
    return unless params[:banner_image]

    chapter.banner_image.purge if chapter.banner_image.attached?
    chapter.banner_image.attach(params[:banner_image])
  end
end
