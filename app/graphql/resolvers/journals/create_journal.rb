class Resolvers::Journals::CreateJournal < GraphQL::Function
  type Types::JournalType

  def call(obj, args, ctx)
    current_user = ctx[:current_user]
    unless current_user.present?
      return GraphQL::ExecutionError.new("You need to be logged in to create a journal")
    end

    journal = current_user.journals.new

    begin 
      journal.save!

      journal
    rescue ActiveRecord::RecordInvalid => err
      GraphQL::ExecutionError.new("Invalid input for Journal: #{journal.errors.full_messages.join(", ")}")
    end
  end
end