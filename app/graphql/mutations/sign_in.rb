Mutations::SignIn = GraphQL::Relay::Mutation.define do
  name "SignIn"
  return_field :token, !types.String
  return_field :errors, types[!types.String]
  return_field :user, Types::UserType

  input_field :email, !types.String
  input_field :password, !types.String

  resolve ->(obj, args, ctx) {
    user = User.find_by_email(args["email"])
    if user && user.valid_password?(args["password"])
      {
        token: user.generate_jwt,
        user: user,
        errors: []
      }
    else
      {
        token: nil,
        errors: ['Email or password is invalid']
      }
    end
  }
end
