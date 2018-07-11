class Resolvers::Chapters::DeleteChapter < GraphQL::Function
  type Types::ChapterType

  argument :chapterId, !types.String

  def call(obj, args, ctx)
    current_user = ctx[:current_user]
    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to delete a chapter")
    end

    begin 
      chapter = Chapter.find(args[:chapterId])
    rescue ActiveRecord::RecordNotFound => err
      return GraphQL::ExecutionError.new("This chapter no longer exists")
    end

    unless chapter.journal.user == current_user
      return GraphQL::ExecutionError.new("You do not have rights to delete this chapter")
    end

    begin 
      chapter.destroy

      chapter
    rescue
      GraphQL::ExecutionError.new("This chapter no longer exists")
    end
  end
end