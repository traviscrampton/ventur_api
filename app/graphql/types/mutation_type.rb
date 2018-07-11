Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :Login, function: Resolvers::Auth::Login.new
  field :CreateJournal, function: Resolvers::Journals::CreateJournal.new
  # field :UpdateJournal, Resolvers::Journals::UpdateJournal.new
end
