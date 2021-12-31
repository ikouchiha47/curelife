class ApplicationController < ActionController::Base
	helper_method :current_user

	private

	def doorkeeper_token
		return nil unless session[:access_token].present?

		@doorkeeper_token ||= Doorkeeper::AccessToken.find_by(token: session[:access_token])

		return nil unless @doorkeeper_token.present?
		return nil if @doorkeeper_token.expired? || @doorkeeper_token.revoked?

		return @doorkeeper_token
	end

	def authenticate!
		(redirect_to patients_login_path and return) unless doorkeeper_token.present?
		return true
	end

	def current_user
		return nil unless doorkeeper_token.present?
		@current_user ||= User.find(doorkeeper_token.resource_owner_id)
	end
end
