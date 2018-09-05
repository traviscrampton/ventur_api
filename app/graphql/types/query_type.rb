Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :user, Types::UserType do
    description "A single user by ID"
    argument :id, types.ID
    resolve ->(obj, args, context) { User.find_by_id(args[:id]) }
  end

  field :journal, Types::JournalType do
    description "A single journal by ID"
    argument :id, types.ID
    resolve ->(obj, args, context) {
      Journal.find_by_id(args[:id])
    }
  end

  field :myJournals, types[Types::JournalType] do
    description "Retrieves a current users journals"
    resolve ->(obj, args, context) { 
      current_user = context[:current_user]
      current_user.journals
    }
  end

  field :allJournals, types[Types::JournalType] do
    description "Retrieves all journals"
    resolve ->(obj, args, context) { Journal.all }
  end

  field :chapter, Types::ChapterType do 
    description "A single journal by ID"
    argument :id, types.ID
    resolve -> (obj, args, context) {
      Chapter.find_by_id(args[:id])
    }
  end

  field :currentUser, Types::UserType do 
    description "gets user information for a single user"
    resolve -> (obj, args, context) {
      context[:current_user]
    }
  end
end
