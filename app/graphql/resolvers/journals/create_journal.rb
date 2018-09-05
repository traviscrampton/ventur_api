class Resolvers::Journals::CreateJournal < GraphQL::Function
  type Types::JournalType
  argument :title, !types.String
  argument :description, !types.String
  argument :stage, !types.String
  argument :status, !types.String
  argument :cardImageUrl, !types.String

  def call(obj, args, ctx)
    current_user = ctx[:current_user]
    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to create a journal")
    end

    journal_params = {
      title: args[:title],
      description: args[:description],
      stage: args[:stage],
      status: args[:status],
      banner_image: args[:cardImageUrl]
    }

    journal = current_user.journals.new(journal_params)
    begin 
      journal.save!

      journal
    rescue ActiveRecord::RecordInvalid => err
      GraphQL::ExecutionError.new("Invalid input for Journal: #{journal.errors.full_messages.join(", ")}")
    end
  end
end