class Resolvers::Auth::Login < GraphQL::Function
  type do
    name 'SigninPayload'
    field :token, types.String
    field :user, Types::UserType
  end

  argument :email, !types.String
  argument :password, !types.String


  def call(obj, args, ctx)
    user = User.find_by_email(args["email"])
    if user && user.valid_password?(args["password"])
      OpenStruct.new({
        user: user,
        token: user.generate_jwt
      })
    else
      GraphQL::ExecutionError.new("Email or password is invalid")
    end
  end
end
