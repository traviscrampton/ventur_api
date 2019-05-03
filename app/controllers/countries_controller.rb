class CountriesController < ApplicationController

  def search_countries
    @countries = Country.where("name ilike ?", "%#{params[:name]}%").limit(5)

    render "countries/search_countries.json"
  end
end