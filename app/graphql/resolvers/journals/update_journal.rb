class Resolvers::Journals::UpdateJournal < GraphQL::Function
  type Types::JournalType

  argument :journalId, !types.String
  argument :title, !types.String
  argument :description, !types.String
  argument :stage, !types.String
  argument :status, !types.String

  def call(obj, args, ctx)
    journal = Journal.find(args[:journalId])
    current_user = ctx[:current_user]

    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to create a journal")
    end

    unless journal.user == current_user
      return GraphQL::ExecutionError.new("You cannot make edit's to this journal")
    end

    journal_params = {
      title: args[:title],
      description: args[:description],
      stage: args[:stage],
      status: args[:status]
    }

    begin 
      journal.update!(journal_params)

      journal
    rescue ActiveRecord::RecordInvalid => err
      GraphQL::ExecutionError.new("Invalid input for Journal: #{journal.errors.full_messages.join(", ")}")
    end
  end
end
