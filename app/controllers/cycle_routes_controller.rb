class CycleRoutesController < ApplicationController
  before_action :cycle_route, except: [:index]
  before_action :check_current_user, except: [:show, :index]


  def index
    @journal = Journal.includes(:cycle_route, chapters: [:cycle_route])
                      .find(params[:journalId])

    polylines = @journal.all_chapters.map do |chapter|
                  chapter.cycle_route.polylines
                end

    render "cycle_routes/index.json", locals: { polylines: polylines }
  end

  def show
    render 'cycle_routes/show.json'
  end

  def editor_show
    previous_polylines = set_previous_polylines

    render 'cycle_routes/editor_show.json', locals: { previous_polylines: previous_polylines }
  end

  def update
    if cycle_route.update(cycle_route_params)
      render 'cycle_routes/show.json'
    else
      render json: { errors: cycle_route.errors.full_messages }, status: 422
    end
  end

  def destroy
    if cycle_route.update(polylines: "")
      render 'cycle_routes/show.json'
    else
      render json: { errors: cycle_route.errors.full_messages }, status: 422
    end

  end

  private
  
  def cycle_route
    @cycle_route ||= CycleRoute.find(params[:id])
  end

  def set_previous_polylines
    chapter = cycle_route.routable
    all_chapters = chapter.journal.all_chapters
    current_chapter_index = all_chapters.index(chapter)

    if all_chapters.length > 1 && current_chapter_index != 0
      previous_chapter_index = current_chapter_index - 1 
      all_chapters[previous_chapter_index].cycle_route.polylines
    else
      return ""
    end
  end

  def cycle_route_params
    params.permit(:polylines, :longitude, :latitude, :latitude_delta, :longitude_delta)
  end
end