class Resolvers::Chapters::CreateChapter < GraphQL::Function
  type Types::ChapterType

  argument :journalId, !types.String
  argument :title, !types.String
  argument :description, !types.String

  def call(obj, args, ctx)
    current_user = ctx[:current_user]

    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to create a chapter")
    end

    begin 
      journal = Journal.find(args[:journalId])
    rescue ActiveRecord::RecordNotFound => e
      return GraphQL::ExecutionError.new("This journal no no exist!")
    end

    chapter = journal.chapters.new(title: args[:title], description: args[:description])

    begin 
      chapter.save!

      chapter
    rescue ActiveRecord::RecordInvalid => err
      GraphQL::ExecutionError.new("Invalid input for chapter: #{chapter.errors.full_messages.join(", ")}")
    end
  end
end