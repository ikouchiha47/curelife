class HomepageController < ApplicationController
	layout 'homepage'
	
	def index
		redirect_to user_bookings_path(current_user) and return if doorkeeper_token.present?
	end
end
