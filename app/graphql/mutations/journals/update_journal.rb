Mutations::Journals::UpdateJournal = GraphQL::Relay::Mutation.define do
  name "UpdateJournal"

  input_field :journalId, types.String
  input_field :title, types.String
  input_field :description, types.String
  input_field :stage, types.String
  input_field :status, types.String

  return_field :journal, Types::JournalType
  return_field :errors, types[!types.String]

  resolve ->(obj, args, ctx) {
    journal = Journal.find(args[:journalId])
    current_user = ctx[:current_user]

    unless current_user.present?
      return {
        errors: ["You need to be logged in to create a journal"]
      }
    end

    if journal.user != current_user
      return {
        errors: ["You cannot make edits to this journal"]
      }
    end

    journal_params = {
      title: args[:title],
      description: args[:description],
      stage: args[:stage],
      status: args[:status]
    }

    if journal.update(journal_params)
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
