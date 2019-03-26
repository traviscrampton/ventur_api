require "csv"

namespace :countries do
  desc 'port countries csv to countries model'
  task port_initial_csv: :environment do
    ActiveRecord::Base.transaction do
      CSV.foreach('db/data/countries.csv', headers: true) do |row|
        country = Country.create(country_code: row[0], latitude: row[1], longitude: row[2], name: row[3].lstrip)
        p "created #{country.name} #{country.country_code}"
      end
    end 
  end
end