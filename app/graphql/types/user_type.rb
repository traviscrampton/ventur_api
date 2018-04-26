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
			"http://localhost:3000" + obj.avatar_image_url	
		}
	end
	
	field :bio, types.String do 
		description "returns a bio for the user"
		resolve -> (obj, args, ctx) {
			obj.bio	
		}
	end

	field :banner_image_url, types.String do 
		description "returns the background image"
		resolve -> (obj, args, ctx) {
			"http://localhost:3000" + obj.banner_image_url	
		}
	end
	
end
