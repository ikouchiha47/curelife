class ApplicationController < ActionController::Base
  helper_method :current_user, :current_doctor, :encrypt_params, :razorpay_api_key

  private

  def doorkeeper_token
    return nil unless session[:access_token].present?

    @doorkeeper_token ||= Doorkeeper::AccessToken.find_by(token: session[:access_token])

    return nil unless @doorkeeper_token.present?
    return nil if @doorkeeper_token.expired? || @doorkeeper_token.revoked?

    @doorkeeper_token
  end

  def authenticate!
    (redirect_to patients_login_path and return) unless doorkeeper_token.present?
    true
  end

  def current_user
    return nil unless doorkeeper_token.present?

    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def current_doctor
    return nil unless doorkeeper_token.present?

    @current_doctor ||= Doctor.find(doorkeeper_token.resource_owner_id)
  end

  def razorpay_api_key
    $config.fetch('RAZORPAY_API')
  end

  def encrypt_params(params)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    crypt.encrypt_and_sign(params.to_json)
  end

  def decrypt_param(enc_param)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    crypt.decrypt_and_verify(enc_param)
  end
end
