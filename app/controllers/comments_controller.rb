class CommentsController < ApplicationController
  before_action :check_current_user, except: [:index]
  before_action :check_for_commentable, only: [:index, :create, :destroy]
  before_action :comment, only: [:update, :destroy]
  before_action :validate_comment_user, only: [:update]

  def index
    # will write this later
  end

  def create
    # will write later
  end

  def update
    # todo: write
  end

  def destroy
    can_delete_comment?

    if comment.delete
      render json: @comment
    else
      render json: { error: "you cannot delete this comment" }
    end
  end

  private

  def check_for_commentable
    if params[:commentableType] &&
       params[:commentableId] &&
       Comment::COMMENTABLE_OPTIONS.include?(params[:commentableType])

      commentable
    else
      render json: { errors: "not comment functionality
                              for #{params[:commentableType]}" },
             status: 404
    end
  end

  def commentable
    @commentable ||= commentable_klass.find(params[:commentableId])
  end

  def commentable_klass
    case params[:commentableType]
    when 'chapter'
      Chapter
    when 'comment'
      Comment
    else
      raise ArgumentError, "#{params[:commentableType]} is not commentable"
    end
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def validate_comment_user
    return if is_comment_owner?

    return_unauthorized_error
  end

  def is_resource_owner?
    commentable.user == current_user
  end

  def is_comment_owner?
    current_user == comment.user
  end

  def can_delete_comment?
    return if is_resource_owner? || is_comment_owner?

    return_unauthorized_error
  end
end
