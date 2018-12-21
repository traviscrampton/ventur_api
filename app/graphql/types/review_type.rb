Types::ReviewType = GraphQL::ObjectType.define do
  name "Review"
  field :id, types.ID
  field :content, types.String
  field :user, Types::UserType
  field :gearItem, Types::GearItemType, property: :gear_item
end
