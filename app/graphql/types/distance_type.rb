Types::DistanceType = GraphQL::ObjectType.define do
  name "Distance"
  field :id, !types.ID
  field :amount, types.Int do 
		resolve ->(obj, args, ctx) {
			obj.amount.to_i
		}
	end
end
