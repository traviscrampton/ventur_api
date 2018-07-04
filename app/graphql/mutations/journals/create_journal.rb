Mutations::Journals::CreateJournal = GraphQL::Relay::Mutation.define do
  name "CreateJournal"
  return_field :journal, Types::JournalType
  return_field :errors, types[!types.String]

  resolve ->(obj, args, ctx) {
    current_user = ctx[:current_user]
    unless current_user.present?
      return {
        errors: ["You need to be logged in to create a journal"]
      }
    end

    journal = current_user.journals.new

    if journal.save
      {
        journal: journal
      }
    else
      {
        errors: journal.errors.full_messages
      }
    end
  }
end
