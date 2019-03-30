class CreateComment
  attr_accessor :commentable, :params

  def initialize(commentable, params)
    @commentable = commentable
    @params = params
  end

  def call
    comment = commentable.comments.new(params)
    comment.save

    comment
  end
end