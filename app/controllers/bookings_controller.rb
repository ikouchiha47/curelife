class BookingsController < ApplicationController
  before_action :authenticate!

  def index
    @locations = Location.take(10)
    @appointments = AppointmentBooking.where(user_id: current_user.id)
    @ambulances = AmbulanceBooking.where(user_id: current_user.id)
    @labtests = LabTestBooking.where(user_id: current_user.id)
  end

  def show
    redirect_to doctors_url(locations: params[:locations], booking_id: params[:id]) and return if params[:id] == '3'
  end

  def new_appointment
    @location_id = params[:location_id]
    @doctor_id = params[:doctor_id]
    @doctorslot = DoctorSlot.find_by(doctor_id: params[:doctor_id], location_id: params[:location_id])

    if @doctorslot.present?
      @available_slots = @doctorslot.available_slots
        .each_with_index.collect {|slot, i| [slot.join(" - "), i]}
        .filter { |t| t[0].present? }

      respond_to { |format| format.js }
      return
    end

    respond_to { |format| format.js { flash.now[:error] = "No avaiable slots" } }
  end

  def create_appointment
    @doctorslot = DoctorSlot.find_by(doctor_id: params[:doctor_id], location_id: params[:location_id])
    expiry = DateTime.strptime(@doctorslot.slots[params[:slot_number].to_i][1], '%H:%M')

    begin
      bp = booking_params.to_hash.merge({
        amount_to_pay: @doctorslot.amount_to_pay,
        expires_at: expiry,
        doctor_slot_id: @doctorslot.id,
        user_id: current_user.id
      })
      p bp

      AppointmentBooking.book!(bp.with_indifferent_access)
    rescue => err
      p err
      p err.message
      flash[:error] = err.message
    else
      flash[:success] = "Booking success"
    end

    redirect_to doctors_url(booking_id: 3, locations: [@doctorslot.location_id.to_s])
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

  private

  def booking_params
    params.permit(:location_id, :doctor_id, :slot_number)
  end
end
