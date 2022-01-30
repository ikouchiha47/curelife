class BookingsController < ApplicationController
	before_action :authenticate!

	def index
		@locations = Location.take(10)
	end

    def show
      if params[:id] == "3"
        redirect_to doctors_url(locations: params[:locations]) and return
      end
    end

    def new_appointment
      @slot = DoctorSlot
        .find_by(doctor_id: params[:doctor_id], location_id: params[:location_id])
        .try(:slots)
    end

    def create_appointment
      @slot = DoctorSlot.find_by(doctor_id: params[:doctor_id], location_id: params[:location_id])
      return unless @slot.book(params[:slot_number])

      slot.transaction do
        booking
      end
    end

    def new_ambulance
    end

    def create_ambulance
    end

	def services
      @locationservice = LocationService.find_by(location_id: params[:location_id])
      @services = @locationservice.try(:available_services) || []
      respond_to { |format| format.js }
	end
end
