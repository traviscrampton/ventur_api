class Comment < ActiveRecord::Base

  COMMENTABLE_OPTIONS = %w(chapter comment)

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates_presence_of :user
  validates_presence_of :commentable
  validates_presence_of :content
end