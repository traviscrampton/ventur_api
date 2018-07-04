Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :signIn, Mutations::SignIn.field
  field :CreateJournal, Mutations::Journals::CreateJournal.field
  field :UpdateJournal, Mutations::Journals::UpdateJournal.field
end
