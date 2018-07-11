class Resolvers::Journals::DeleteJournal < GraphQL::Function
  type Types::JournalType

  argument :journalId, !types.String

  def call(obj, args, ctx)
    current_user = ctx[:current_user]
    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to delete a journal")
    end

    begin 
      journal = Journal.find(args[:journalId])
    rescue ActiveRecord::RecordNotFound => err
      return GraphQL::ExecutionError.new("This journal no longer exists")
    end

    unless journal.user == current_user
      return GraphQL::ExecutionError.new("You do not have rights to delete this journal")
    end

    begin 
      journal.destroy

      journal
    rescue
      GraphQL::ExecutionError.new("This journal no longer exists")
    end
  end
end