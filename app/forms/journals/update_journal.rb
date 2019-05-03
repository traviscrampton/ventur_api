class UpdateJournal

    attr_accessor(
    :journal,
    :non_image_params,
    :banner_image
  )

  def initialize(id, non_image_params, banner_image)
    @non_image_params = non_image_params
    @banner_image = banner_image
    @journal = Journal.find(id)
  end

  def call
    if journal.update
      update_distance_metrics
    end

    handle_image_upload

    journal
  end

  private

  def update_distance_metrics
    return unless non_image_params[:distanceType]

    journal.distance.update(distance_type: non_image_params[:distanceType])
  end

  def handle_image_upload
    return if banner_image
    
    @journal.banner_image.purge if @journal.banner_image.attached?
    @journal.banner_image.attach(params[:banner_image]) 
  end
end
