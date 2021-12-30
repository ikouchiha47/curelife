class BookingsController < ApplicationController
	before_action :authenticate!

	def index
		@locations = Location.take(10)
	end

	def services
		@services = LocationService.find_by(location_id: params[:location_id]).try(:available_services) || []
		respond_to { |format| format.js }
	end
end
