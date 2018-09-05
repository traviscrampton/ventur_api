Types::JournalType = GraphQL::ObjectType.define do
  name "Journal"
  field :id, !types.ID
  field :title, !types.String
  field :slug, !types.String
  field :description, !types.String
  field :status, !types.String
  field :stage, !types.String
  field :chapters, types[Types::ChapterType]
  field :gearItems, types[Types::GearItemType], property: :gear_items
  field :gearItemCount, types.Int, property: :gear_item_count
  field :webBannerImageUrl, types.String, property: :web_banner_image_url
  field :cardBannerImageUrl, types.String, property: :card_banner_image_url
  field :miniBannerImageUrl, types.String, property: :mini_banner_image_url
  field :distance, types.Int, property: :total_distance
  field :user, Types::UserType
end
