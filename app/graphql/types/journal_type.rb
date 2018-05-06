Types::JournalType = GraphQL::ObjectType.define do
  name "Journal"
  field :id, !types.ID
  field :title, !types.String
  field :slug, !types.String
  field :description, !types.String
  field :status, !types.String
  field :chapters, types[Types::ChapterType]
  field :gearItems, types[Types::GearItemType], property: :gear_items
  field :gearItemCount, types.Int, property: :gear_item_count
  field :cardImageUrl, types.String, property: :banner_image_url
  field :distance, types.Int, property: :total_distance
  field :user, Types::UserType
end
