class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate_token

  def authenticate_token
    Rails.logger.debug("WHAT AUTHORIZATION#{request.headers['Authorization']}")
    if request.headers['Authorization'].present?
      Rails.logger.debug("HERE ARE THEY CLAIM IT's PRESENT")
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end

  def current_user
    @current_user = @current_user_id ? User.find(@current_user_id) : nil
  end

  def check_current_user
    return if current_user

    return_unauthorized_error
  end

  def return_unauthorized_error
    render json: { errors: "You are not authorized to do this"}, status: 401
  end
end
