namespace :port_followers do
  desc 'port countries csv to countries model'
  task :journal, [:first_journal_id, :second_journal_id] => :environment do |t, args|
    ActiveRecord::Base.transaction do
      from_journal = Journal.find(args[:first_journal_id])
      to_journal = Journal.find(args[:second_journal_id])

      from_journal.journal_follows.each do |from_journal_follow|
        journal_follow = JournalFollow.create(journal_id: to_journal.id,
                             user_email: from_journal_follow.user_email,
                             user_id: from_journal_follow.user_id)
        p "journal follow created #{journal_follow.user_email}"
      end
      p "finished porting journals"
    end 
  end
end