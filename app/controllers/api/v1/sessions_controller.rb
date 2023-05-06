class Api::V1::SessionsController < ActionController::API
  include JwtAuth::Helpers
  include VerificationHelper
  include LazyLookup

  def sign_up
    user = User.create!(user_params)

    session = login!(user)

    update_session_device!(session)

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: user.role
  end

  def sign_in
    user = User.find_by(email: params[:email])

    raise Errors::BadParameter, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    session = login!(user)

    update_session_device!(session)

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: user.role
  end

  def sign_out
    logout!
    expose
  end

  def refresh
    session = refresh!

    update_session_device!(session)

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: session.user.role
  end

  def send_verification_code
    user = User.find_by(email: params[:email])
    raise Errors::BadParameter, t(:email_not_found) unless user

    send_verification_code_to(user)

    expose
  end

  def reset_password
    user = User.find_by(email: params[:email])
    raise Errors::BadParameter, t(:verification_code_invalid) unless verification_code_valid?(user, params[:verification_code])

    user.update!(password: params[:password])

    expose
  end

  private

  def update_session_device!(session)
    return unless request.headers['Exponent-Token']

    Device.where(
      'exponent_token = ? or session_id = ?',
      request.headers['Exponent-Token'],
      session.id
    ).delete_all

    Device.create!(
      exponent_token: request.headers['Exponent-Token'],
      session_id: session.id
    )
  end

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
