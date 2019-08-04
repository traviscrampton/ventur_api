class StravaAuthsController < ApplicationController
  def show
  end

  def create
    strava_auth = current_user.strava_auth
    if strava_auth.update(access_token: params[:stravaAccessToken],
                          refresh_token: params[:stravaRefreshToken],
                          expires_at: params[:stravaExpiresAt])
      render json: {
        stravaAccessToken: strava_auth.access_token,
        stravaRefreshToken: strava_auth.refresh_token,
        stravaExpiresAt: strava_auth.expires_at
      }
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end
end