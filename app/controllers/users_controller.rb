class UsersController < ApplicationController
	def logout
		if current_user.present?
			doorkeeper_token.update(expires_in: 0, revoked_at: DateTime.now)
		end

		redirect_to root_url
	end
end
