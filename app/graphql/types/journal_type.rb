Types::JournalType = GraphQL::ObjectType.define do
  name "Journal"
  field :id, types.ID
  field :title, types.String
  field :slug, types.String
  field :description, types.String
  field :status, types.String
  field :stage, types.String
  field :followCount, types.Int, property: :follow_count
  field :chapters, types[Types::ChapterType] do 
    resolve ->(obj, args, context) {
      context[:current_user] && obj.user_id == context[:current_user].id ? obj.all_chapters : obj.published_chapters
    }
  end

  field :isFollowing, types.Boolean do 
    resolve ->(obj, args, context) {
      return false if !context[:current_user]

      obj.journal_follows.map(&:user_id).include?(context[:current_user].id)
    }
  end
  
  field :gearItems, types[Types::GearItemType], property: :gear_items
  field :gearItemCount, types.Int, property: :gear_item_count
  field :webBannerImageUrl, types.String, property: :web_banner_image_url
  field :cardBannerImageUrl, types.String, property: :card_banner_image_url
  field :miniBannerImageUrl, types.String, property: :mini_banner_image_url
  field :distance, types.Int, property: :total_distance
  field :user, Types::UserType
end
