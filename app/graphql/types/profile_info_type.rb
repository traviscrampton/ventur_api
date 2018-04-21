Types::ProfileInfoType = GraphQL::ObjectType.define do
  name "ProfileInfo"
  field :id, !types.ID
	
	field :avatar, types.String do
	  resolve ->(obj, args, ctx) {
	    "http://localhost:3000" + obj.avatar.url(:small)
	  }
	end
end
