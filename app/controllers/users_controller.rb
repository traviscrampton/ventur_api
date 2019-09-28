class UsersController < ApplicationController
  skip_before_action :authenticate_token, except: [:update, :update_strava_token]

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.valid_password?(params[:password])
      render json: login_user_json
    else
      render json: { errors: ['Email or password is invalid']}, status: 422
    end
  end

  def journals
    @user = User.includes(journals: [:distance, :banner_image_attachment])
                .find(params[:id])

    render "users/user_journals.json", locals: { journals: @user.journals }
  end

  def show
    @user = User.with_attached_avatar
                .includes(journals: [:distance, banner_image_attachment: :blob])
                .find(params[:id])

    render 'users/show.json'
  end

  def create
    @user = User.new(non_image_params)
    if @user.save
      update_journal_follows
      upload_avatar_image
      create_strava_auth
      render json: login_user_json
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

  def update_strava_token
    @user = current_user

    if @user.update(strava_auth_token: params[:authToken])
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
    return unless params[:avatar]

    @user.avatar.purge if @user.avatar.attached?
    @user.avatar.attach(params[:avatar])
  end

  def update_journal_follows
    JournalFollow.where(user_email: @user.email)
                 .update_all(user_id: @user.id)
  end

  def create_strava_auth
    StravaAuth.create(user_id: @user.id)
  end

  def user_json
    {
      user: {
        id: @user.id,
        email: @user.email,
        firstName: @user.first_name,
        lastName: @user.last_name,
        avatarImageUrl: @user.avatar_image_url
      }
    }
  end

  def login_user_json
    user_json.merge(token: @user.generate_jwt, stravaAccessToken: @user.strava_auth.access_token, stravaRefreshToken: @user.strava_auth.refresh_token, stravaExpiresAt: @user.strava_auth.expires_at)
  end
end
