class CreateComment
  attr_accessor :commentable, :params

  def initialize(commentable, params)
    @params = params
  end

  def call
    comment = commentable.comments.new(params)
    comment.save
    # there is going to be something about firing off an email notification at
    # somepoint
  end
end