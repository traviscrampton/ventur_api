class JournalFollow < ActiveRecord::Base

  belongs_to :user
  belongs_to :journal

  validates_presence_of :user_email
  validates :user_email, uniqueness: { case_sensitive: false }
end