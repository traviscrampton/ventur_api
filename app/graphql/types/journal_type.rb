Types::JournalType = GraphQL::ObjectType.define do
  name "Journal"
  field :id, !types.ID
  field :title, !types.String
  field :slug, !types.String
  field :description, !types.String
	field :status, !types.String
	
	field :distance, types.Int do 
		resolve ->(obj, args, ctx) {
			obj.distance.amount.to_i
		}
	end
	
	field :card_image_url, types.String do
		resolve ->(obj, args, ctx) {
			"http://localhost:3000" + obj.banner_image.url(:card)
		}
	end
	
	field :gear_item_count, types.Int do 
		resolve -> (obj, args, ctx) {
			obj.gear_items.count
		}
	end
	
	field :chapters, types[Types::ChapterType] do 
		resolve -> (obj, args, ctx) {
			obj.chapters
		} 
	end

  field :user, Types::UserType do
    description "user associated with a specific journal"
    resolve -> (obj, arg, ctx) {
      user = obj.user
    }
  end
end
