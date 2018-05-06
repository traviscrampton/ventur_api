Types::GearItemType = GraphQL::ObjectType.define do
  name "GearItem"
  field :id, !types.ID
  field :title, !types.String
  field :price, types.Int, property: :price_to_i
  field :amountDonated, types.Int, property: :donated_to_i
  field :productImageUrl, types.String, property: :product_image_url
  field :reviews, types[Types::ReviewType]
end
