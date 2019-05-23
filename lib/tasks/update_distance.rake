namespace :update_distance do
  desc 'update new distance modeling'
  task :journal => :environment
    ActiveRecord::Base.transaction do
      Journal.all.each do |journal|
        # first update the journal distance_type and then handle math.
        journal_distance_amount = journal.distance.amount
        journal.distance.update(distance_type: "kilometer", kilometer_amount: journal_distance_amount, mile_amount: journal_distance_amount*0.6 )
        p "updated distance for journal #{journal.id} #{journal.title} "
        journal.chapters.each do |chapter|
          # then update all chapters distance. 
          chapter_distance_amount = chapter.distance.amount
          chapter.distance.update(distance_type: "kilometer", kilometer_amount: chapter_distance_amount, mile_amount: chapter_distance_amount*0.6)
          p "updated distance for distance for chapter #{chapter.id} #{chapter.title}"
        end
      end
    end 
  end
end