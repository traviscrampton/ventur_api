class UpdateJournal

    attr_accessor(
      :journal,
      :banner_image,
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
      update_included_countries
    end

    handle_image_upload

    journal.reload
    journal
  end

  private

  def journal_params
    {
      title: params[:title],
      status: params[:status].try(:parameterize).try(:underscore),
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

  def update_included_countries
    return unless params[:includedCountries]

    current_ids = journal.countries.map { |c| c.id }
    params_ids = params[:includedCountries].map {|c| c[:id]}

    delete_included_countries(current_ids, params_ids)
    create_included_countries(current_ids, params_ids)
  end

  def delete_included_countries(current_ids, params_ids)

    current_ids.each do |current_id|
      next if params_ids.include?(current_id)
      journal.included_countries.find_by(country_id: current_id).destroy
    end
  end

  def create_included_countries(current_ids, params_ids)
    params_ids.each do |param_id|
      next if current_ids.include?(param_id)
      journal.included_countries.create(country_id: param_id)
    end
  end

  def handle_image_upload
    return unless banner_image
    
    @journal.banner_image.purge if @journal.banner_image.attached?
    @journal.banner_image.attach(banner_image) 
  end
end
