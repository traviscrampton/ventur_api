class CredentialsController < ApplicationController

  def index
    render json: {
      awsSecretKey: "SwYeR8JsIgVYQlslEUa97iEMw+mrxp0NZhL13W4N",
      awsAccessKey: "AKIAJ4GWDLYJTZQZQ2CQ",
      stravaClientId: "37236",
      stravaClientSecret: "15ef2578169c161824da951d96c8e9be45cd8588"
    }
  end
end