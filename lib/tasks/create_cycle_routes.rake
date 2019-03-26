namespace :create_cycle_routes do
  desc 'port countries csv to countries model'
  task port: :environment do
    ActiveRecord::Base.transaction do
      Journal.all.each do |journal|
        country = journal.countries.try(:first)
        journal.chapters.each do |chapter|
          if country
            p "created a cycle route for country #{country.name}"
            chapter.create_cycle_route(latitude: country.latitude, longitude: country.longitude, longitude_delta: 20.0, latitude_delta: 20.0 )
          else
            p "created generic cycle route for #{chapter.id}"
            chapter.create_cycle_route(latitude: 37.680806933177, longitude: -122.441652216916, longitude_delta: 20.0, latitude_delta: 20.0 )
          end
        end
      end
    end 
  end
end