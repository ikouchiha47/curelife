class AppointmentsController < ApplicationController
  before_action :authenticate!

  def new
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

  def create
    @doctorslot = DoctorSlot.find_by(doctor_id: params[:doctor_id], location_id: params[:location_id])
    expiry = DateTime.strptime(@doctorslot.slots[params[:slot_number].to_i][1], '%H:%M')

    begin
      bp = booking_params.to_hash.merge({
        amount_to_pay: @doctorslot.amount_to_pay,
        expires_at: expiry,
        doctor_slot_id: @doctorslot.id,
        user_id: current_user.id
      })

      AppointmentBooking.book!(bp.with_indifferent_access)
    rescue => err
      puts err
      flash[:error] = 'Slot Booking Failed. Please Retry!'
    else
      flash[:success] = 'Booking success'
    end

    redirect_to doctors_url(booking_id: 3, locations: [@doctorslot.location_id.to_s])
  end


  def delete
    @appointment = AppointmentBooking.find(params[:id])
    if @appointment.user_id != current_user.id
      flash[:error] = 'Failed to cancel others booking.'
      redirect_to user_bookings_url(current_user.id) and return
    end

    begin
      @appointment.expire!
    rescue => e
      puts e
      flash[:error] = 'Failed to cancel booking. Please Retry!'
    else
      flash[:success] = 'Booking cancelled'
    end

    redirect_to user_bookings_url(current_user.id)
  end

  def update
  end

end
