class CreateChapter < ChapterForm
  attr_accessor(
    :journal,
    :chapter,
    :params
  )

  DEFAULT_MAP_INITIAL_REGION = {
     latitude: 37.680806933177,
     longitude: -122.441652216916,
     longitude_delta: 0.428847994931687,
     latitude_delta: 0.514117272451202
  }

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
    create_cycle_route
  end

  def create_chapter_distance
    chapter.create_new_distance(params[:distance] || 0)
    chapter.update_total_distance
  end

  def create_cycle_route
    journal = chapter.journal

    if journal.chapters.count > 1
      all_chapters = journal.all_chapters
      created_chapter_index = all_chapters.index(chapter)
      prev_route = journal.all_chapters[created_chapter_index - 1].cycle_route
      cycle_route_params = {
        latitude: prev_route.latitude,
        longitude: prev_route.longitude,
        longitude_delta: prev_route.longitude_delta,
        latitude_delta: prev_route.latitude_delta
      }
    elsif journal.countries.any?
      country = journal.countries.first
      cycle_route_params = {
        latitude: country.latitude,
        longitude: country.longitude,
        longitude_delta: 9.97896199383848,
        latitude_delta: 15.1292631087431
      }
    else 
      cycle_route_params = DEFAULT_MAP_INITIAL_REGION 
    end

    chapter.create_cycle_route(cycle_route_params)
  end

  def create_editor_blob
    chapter.create_editor_blob
  end
end
