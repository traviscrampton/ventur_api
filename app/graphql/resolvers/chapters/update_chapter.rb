class Resolvers::Chapters::UpdateChapter < GraphQL::Function
  type Types::ChapterType

  argument :chapterId, !types.String
  argument :title, !types.String
  argument :description, !types.String

  def call(obj, args, ctx)
    current_user = ctx[:current_user]

    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to create a chapter")
    end

    begin 
      chapter = Chapter.find(args[:chapterId])
    rescue ActiveRecord::RecordNotFound => e
      return GraphQL::ExecutionError.new("This chapter no no exist!")
    end

    unless current_user == chapter.journal.user
      return GraphQL::ExecutionError.new("You are not authorized to update this journal")
    end

    chapter_params = {
      title: args[:title],
      description: args[:description]
    }

    begin 
      chapter.update!(chapter_params)

      chapter
    rescue ActiveRecord::RecordInvalid => err
      GraphQL::ExecutionError.new("Invalid input for chapter: #{chapter.errors.full_messages.join(", ")}")
    end
  end
end