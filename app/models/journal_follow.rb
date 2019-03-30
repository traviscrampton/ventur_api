class JournalFollow < ActiveRecord::Base

  belongs_to :user
  belongs_to :journal

  validates_presence_of :user_email
  validates_uniqueness_of :user_email, scope: :journal_id

end