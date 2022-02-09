require 'securerandom'

class Payment
  def self.create!(booking, doctorslot)
    order = Razorpay::Order.create(
      amount: booking.amount_to_pay.to_i * 100,
      currency: 'INR',
      receipt: booking.id.to_s
    )

    begin
      b = Booking.create!(
        bookable_id: booking.id,
        bookable_type: 'appointment_booking',
        uuid: SecureRandom.hex(10),
        doctor_id: doctorslot.doctor_id,
        user_id: booking.user_id,
        razorpay_order_id: order.id,
        status: :inprogress,
        expires_at: DateTime.now + 1.hour
      )
    rescue => err
      booking.expire!
      raise err
    end

    b
  end
end
