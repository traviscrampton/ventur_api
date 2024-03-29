Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, types.ID
  field :email, types.String
  field :firstName, types.String, property: :first_name
  field :lastName, types.String, property: :last_name
  field :fullName, types.String, property: :full_name
  field :journals, types[Types::JournalType]
  field :journalCount, types.Int, property: :journal_count
  field :totalDistance, types.Int, property: :total_distance
  field :avatarImageUrl, types.String, property: :avatar_image_url
  field :bannerImageUrl, types.String, property: :banner_image_url
  field :gearItems, types[Types::GearItemType], property: :gear_items
  field :admin, types.Boolean
  field :canCreate, types.Boolean, property: :can_create
end
