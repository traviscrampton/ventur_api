Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  
  field :user, Types::UserType do
    description "A single user by ID"
    argument :id, types.ID
    resolve ->(obj, args, context) { User.find_by_id(args[:id]) }
  end
end
