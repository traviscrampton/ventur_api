Types::JournalType = GraphQL::ObjectType.define do
  name "Journal"
  field :id, !types.ID
  field :title, !types.String
  field :slug, !types.String
  field :description, !types.String
	field :status, !types.String
	
	field :distance, Types::DistanceType do 
		resolve ->(obj, args, ctx) {
			obj.distance
		}
	end
	
	field :card_image, types.String do
		resolve ->(obj, args, ctx) {
			"http://localhost:3000" + obj.banner_image.url(:card)
		}
	end

  field :user, Types::UserType do
    description "user associated with a specific journal"
    resolve -> (obj, arg, ctx) {
      user = obj.user
    }
  end
end
