Types::ChapterType = GraphQL::ObjectType.define do
  name "Chapter"
  field :id, types.ID
  field :title, types.String
  field :slug, types.String
  field :description, types.String
  field :stage, types.String
  field :distance, types.Int, property: :distance_to_i
  field :imageUrl, types.String, property: :image_url
  field :offline, types.Boolean
  field :bannerImageUrl, types.String, property: :banner_image_url
  field :readableDate, types.String, property: :readable_date
  field :user, Types::UserType, property: :user
  field :journal, Types::JournalType, property: :journal
  field :content, types.String
end
