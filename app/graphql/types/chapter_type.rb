Types::ChapterType = GraphQL::ObjectType.define do
  name "Chapter"
  field :id, !types.ID
  field :title, !types.String
  field :slug, !types.String
  field :description, !types.String
	field :status, !types.String
	field :distance, types.Int, property: :distance_to_i
	field :imageUrl, types.String, property: :image_url
	field :dateCreated, types.String, property: :readable_date
end
