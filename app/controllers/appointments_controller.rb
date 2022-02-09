class AppointmentsController < ApplicationController
  before_action :authenticate!

  def new
    @location_id = booking_info[:location_id]
    @doctor_id = booking_info[:doctor_id]
    @doctorslot = DoctorSlot.find_by(doctor_id: @doctor_id, location_id: @location_id)

    if @doctorslot.present?
      @available_slots = @doctorslot.available_slots
        .each_with_index.collect {|slot, i| [slot.join(' - '), i]}
        .filter { |t| t[0].present? }
    end

    return if @available_slots.present?

    flash[:error] = 'No avaiable slots'
    redirect_to doctors_url(booking_id: booking_info[:booking_id], locations: @location_id)
  end

  def create
    @doctorslot = DoctorSlot.find_by(doctor_id: booking_info[:doctor_id], location_id: booking_info[:location_id])
    expiry = DateTime.strptime(@doctorslot.slots[params[:slot_number].to_i][1], '%H:%M')

    begin
      bp = booking_info.merge({
        amount_to_pay: @doctorslot.amount_to_pay,
        expires_at: expiry,
        doctor_slot_id: @doctorslot.id,
        user_id: current_user.id,
        slot_number: params[:slot_number]
      })

      @order = AppointmentBooking.book!(bp.with_indifferent_access)
    rescue => err
      Rails.logger.error err
      flash[:error] = 'Slot Booking Failed. Please Retry!'
      redirect_to doctors_url(booking_id: 3, locations: [@doctorslot.location_id.to_s]) and return
    end

    begin
      @payment = Payment.create!(@order, @doctorslot)
    rescue => err
      Rails.logger.error err
      flash[:error] = 'Payment failed'
    rescue => err
      Rails.logger.error err
      flash[:error] = 'Something went wrong. Please contact ccu'
    end

    if flash[:error].present?
      redirect_to doctors_url(booking_id: 3, locations: [@doctorslot.location_id.to_s]) and return
    end

    redirect_to payments_url
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

  private

  def booking_params
    params.permit(:slot_number, :booking_id)
  end

  def booking_info
    bid = decrypt_param(params[:booking_id])
    return {} unless bid.present?

    @booking_info ||= JSON.parse(bid).with_indifferent_access
  end

end
