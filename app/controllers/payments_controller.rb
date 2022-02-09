class PaymentsController < ApplicationController
  before_action :authenticate!

  def new
    begin
      @appointment = if booking.bookable_type == 'appointment_booking'
                   AppointmentBooking.find(booking.bookable_id)
                 else
                   flash[:error] = 'Booking has expired'
                   return
                 end
      @user = Patient.find(@appointment.user_id)

    rescue => err
      Rails.logger.error err
      flash[:error] = 'Something went wrong'
      @appointment.expire!
    end

    # respond_to do |format|
    # format.js
    # end
  end

  def create
    binding.pry

    booking.update!(
      razorpay_checkout_id: create_params[:razorpay_payment_id],
      status: :confirmed,
      metadata: {razorpay_signature: create_params[:razorpay_signature]}.to_json
    )

    flash[:success] = 'Booking successfull'
    redirect_to user_bookings_url(current_user)
  end

  def delete
    binding.pry

    booking.update!(
      status: :failed,
      metadata: {
        error_code: params[:error_code],
        error_source: params[:error_source],
        reason: params[:reason],
        error_order_id: params[:error_order_id],
        error_payment_id: params[:error_payment_id]
      }.to_json
    )
    
    AppointmentBooking.find(booking.bookable_id).expire!
  end

  private

  def booking
    @booking ||= current_user.booking
  end

  def validate_booking
    return true if booking.present?

    flash[:error] = 'Booking is no longer valid'
    redirect_to user_bookings_url(user_id: current_user.id)
  end

  def create_params
    params.permit(:razorpay_order_id, :razorpay_payment_id, :razorpay_signature)
  end
end
