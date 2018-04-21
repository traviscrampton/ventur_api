Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :firstName, !types.String, property: :first_name
  field :lastName, !types.String, property: :last_name

  field :journals, types[Types::JournalType] do
    description "all journals for a specific user"
    resolve -> (obj, args, ctx) {
      obj.journals
    }
  end
	
	field :profile_info, Types::ProfileInfoType do 
		description "returns profile info"
		resolve -> (obj, args, ctx) {
			obj.profile_info
		}
	end
end
