Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :firstName, !types.String, property: :first_name
  field :lastName, !types.String, property: :last_name
	field :fullName, !types.String, property: :full_name
	field :journals, types[Types::JournalType]
	field :bio, !types.String
	field :journalCount, types.Int, property: :journal_count
	field :totalDistance, types.Int, property: :total_distance
	field :avatarImageUrl, types.String, property: :avatar_image_url
	field :bannerImageUrl, types.String, property: :banner_image_url
end
