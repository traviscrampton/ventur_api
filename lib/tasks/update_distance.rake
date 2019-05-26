namespace :update_distance do
  desc 'update new distance modeling'
  task :port_distance => :environment do 
    ActiveRecord::Base.transaction do
      Distance.all.each do |distance|
        amount = distance.amount
        distance.update(kilometer_amount: amount, mile_amount: amount * 0.6, distance_type: "kilometer")
        p "distance #{distance.id} updated"
      end   
    end 
  end  
end