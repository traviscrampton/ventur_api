class CreateJournal

    attr_accessor(
    :current_user,
    :journal,
    :non_image_params,
    :banner_image
  )

  DEFAULT_MAP_INITIAL_REGION = {
    latitude: 37.680806933177,
    longitude: -122.441652216916,
    longitude_delta: 0.428847994931687,
    latitude_delta: 0.514117272451202
  }

  def initialize(non_image_params, current_user, banner_image)
    @non_image_params = non_image_params
    @banner_image = banner_image
    @current_user = current_user
    @journal = current_user.journals.new(non_image_params)
  end

  def call
    if journal.save
      create_additional_records
      attach_banner_image
    end

    journal
  end

  private

  def create_additional_records
    create_journal_distance
    create_cycle_route
    create_editor_blob
  end

  def create_journal_distance
    # journal.create_distance(amount: 0, jou)
  end

  def create_cycle_route
    journal.create_cycle_route(DEFAULT_MAP_INITIAL_REGION)
  end

  def create_editor_blob
    journal.create_edtior_blob
  end

  def attach_banner_image
    journal.banner_image.attach(params[:banner_image]) if params[:banner_image]
  end
end
