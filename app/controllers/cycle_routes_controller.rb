class CycleRoutesController < ApplicationController
  before_action :cycle_route

  def create
    # these should be created on create of a chapter
  end

  def show
    render 'cycle_routes/show.json'
  end

  def update
    if cycle_route.update(cycle_route_params)
      render 'cycle_routes/show.json'
    else
      render json: { errors: cycle_route.errors.full_messages }, status: 422
    end
  end

  def destroy
    # used for clearing a route completely
  end

  private
  
  def cycle_route
    @cycle_route ||= CycleRoute.find(params[:id])
  end

  def cycle_route_params
    params.permit(:polylines, :longitude, :latitude, :longitude_delta, :latitude_delta)
  end
end