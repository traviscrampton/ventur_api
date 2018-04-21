Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :signIn, Mutations::SignIn.field
end
