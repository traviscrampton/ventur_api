class UsersController < ApplicationController
  skip_before_action :authenticate_token  

  def create
    @user = User.new(non_image_params)
    if @user.save
      upload_avatar_image
      render json: user_json
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(non_image_params)
      upload_avatar_image
      render json: user_json
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  private 

  def non_image_params
    params.permit(:email, :password, :first_name, :last_name)
  end

  def upload_avatar_image
    return if !params[:avatar]

    @user.avatar.purge if @user.avatar.attached?
    @user.avatar.attach(params[:avatar]) 
  end

  def user_json 
    {
      id: @user.id,
      email: @user.email,
      firstName: @user.first_name,
      lastName: @user.last_name,
    }
  end
end