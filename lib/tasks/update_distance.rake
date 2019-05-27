# namespace :update_distance do
#   desc 'update new distance modeling'
#   task :port_distance => :environment do 
#     ActiveRecord::Base.transaction do
#       Journal.all.each do |journal|
#         journal_distance_amount = journal.distance.kilometer_amount
#         if [11, 28].include?(journal.id)
#           p "begin update for journal #{journal.id}"
#           journal.distance.update(mile_amount: journal_distance_amount, kilometer_amount: journal_distance_amount*1.6, distance_type: "mile")
#           p "journal #{journal.id} updated to mile"
#           journal.chapters.each do |chapter|
#             chapter_distance_amount = chapter.distance.kilometer_amount
#             chapter.distance.update(mile_amount: chapter_distance_amount, kilometer_amount: chapter_distance_amount*1.6, distance_type: "mile" )
#             p "chapter #{chapter.id} updated to mile"
#           end
#         else
#           p "begin update for journal #{journal.id}"
#           journal.distance.update(kilometer_amount: journal_distance_amount, mile_amount: journal_distance_amount*0.6, distance_type: "kilometer")
#           p "journal #{journal.id} updated to kilometer "
#           journal.chapters.each do |chapter|
#             chapter_distance_amount = chapter.distance.kilometer_amount
#             chapter.distance.update(kilometer_amount: chapter_distance_amount, mile_amount: chapter_distance_amount*0.6, distance_type: "kilometer")
#             p "chapter #{chapter.id} updated to kilometer"
#           end
#         end
#       end
#     end 
#   end  
# end