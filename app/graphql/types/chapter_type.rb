Types::ChapterType = GraphQL::ObjectType.define do
  name "Chapter"
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
	
	field :image_url, types.String do
		resolve ->(obj, args, ctx) {
			"http://localhost:3000" + obj.image.url(:card)
		}
	end

  field :date_created, types.String do
  	resolve ->(obj, args, ctx) {
			obj.created_at.strftime("%B %d, %Y")
		}
  end
end
