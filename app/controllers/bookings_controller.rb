class BookingsController < ApplicationController
  before_action :authenticate!

  def index
    @locations = Location.take(10)
    @appointments = AppointmentBooking
      .where(user_id: current_user.id).order(created_at: :desc)

    @ambulances = AmbulanceBooking
      .where(user_id: current_user.id).order(created_at: :desc)

    @labtests = LabTestBooking
      .where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    redirect_to doctors_url(locations: params[:locations], booking_id: params[:id]) and return if params[:id] == '3'
  end

  def services
    @locationservice = LocationService.find_by(location_id: params[:location_id])
    @services = @locationservice.try(:available_services) || []
    respond_to { |format| format.js }
  end

  private

  def booking_params
    params.permit(:location_id, :doctor_id, :slot_number)
  end
end
