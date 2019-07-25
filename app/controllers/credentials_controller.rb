class CredentialsController < ApplicationController

  def index
    render json: {
      awsSecretKey: ENV["AWS_SECRET_KEY"],
      awsAccessKey: ENV["AWS_ACCESS_KEY"],
      stravaClientId: ENV["STRAVA_CLIENT_ID"],
      stravaClientSecret: ENV["STRAVA_CLIENT_SECRET"]
    }
  end
end