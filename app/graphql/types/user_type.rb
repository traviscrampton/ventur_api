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
	
	field :avatar_image_url, types.String do 
		description "returns profile avatar"
		resolve -> (obj, args, ctx) {
			"http://localhost:3000" + obj.profile_info.avatar.url(:small)	
		}
	end
end
