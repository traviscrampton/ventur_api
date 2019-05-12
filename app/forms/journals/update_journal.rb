class UpdateJournal

    attr_accessor(
      :journal,
      :params
    )

  def initialize(params)
    @params = params
    @banner_image = params[:banner_image]
    @journal = Journal.find(params[:id])
  end

  def call
    if journal.update(journal_params)
      update_distance_metrics
    end

    handle_image_upload

    journal
  end

  private

  def journal_params
    {
      title: params[:title],
      status: params[:status],
      description: params[:description]
    }
  end

  def update_distance_metrics
    return unless params[:distanceType]

    if journal.distance.update(distance_type: params[:distanceType].try(:singularize))
      update_all_chapters_distance
    end
  end

  def update_all_chapters_distance
    journal.chapters.map(&:distance).each do |chapter_distance|
      chapter_distance.update(distance_type: params[:distanceType].try(:singularize))
    end
  end

  def handle_image_upload
    return unless banner_image
    
    @journal.banner_image.purge if @journal.banner_image.attached?
    @journal.banner_image.attach(banner_image) 
  end
end
