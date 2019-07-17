class CreateJournal

    attr_accessor(
      :current_user,
      :journal,
      :params,
      :banner_image
    )

  DEFAULT_MAP_INITIAL_REGION = {
    latitude: 37.680806933177,
    longitude: -122.441652216916,
    longitude_delta: 0.428847994931687,
    latitude_delta: 0.514117272451202
  }

  def initialize(params, current_user)
    @params = params
    @banner_image = params[:banner_image]
    @journal = current_user.journals.new(journal_params)
  end

  def call
    if journal.save
      create_additional_records
      attach_banner_image
    end

    journal
  end

  private

  def journal_params
    {
      title: params[:title],
      status: params[:status],
      description: params[:description],
    }
  end

  def create_additional_records
    create_journal_distance
    create_included_countries
    create_cycle_route
    create_editor_blob
  end

  def create_journal_distance
    distance_type = params[:distanceType] ? params[:distanceType] : "kilometer"
    
    journal.create_distance(kilometer_amount: 0,
                            mile_amount: 0,
                            distance_type: distance_type.try(:singularize))
  end

  def create_included_countries
    return if params[:includedCountries].nil?
    return if params[:includedCountries].empty?

    params[:includedCountries].each do |included_country|
      journal.included_countries.create(country_id: included_country[:id])
    end
  end

  def create_cycle_route
    country = journal.countries.first
    coordinates = if country
                    DEFAULT_MAP_INITIAL_REGION.merge({
                      latitude: country.latitude,
                      longitude: country.longitude
                    })
                  else 
                    DEFAULT_MAP_INITIAL_REGION
                  end  

    journal.create_cycle_route(coordinates)
  end

  def create_editor_blob
    journal.create_editor_blob
  end

  def attach_banner_image
    journal.banner_image.attach(banner_image) if banner_image
  end
end
