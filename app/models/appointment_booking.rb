class AppointmentBooking < ApplicationRecord
  include Bookable
  enum status: {
    booked: 'booked',
    confirmed: 'confirmed',
    paymentfail: 'paymentfail',
    canceled: 'cancelled'}

  validates :doctor_slot_id, :slot_number, presence: true

  belongs_to :doctor
  belongs_to :user

  def expired?
    expires_at < DateTime.now
  end

  def expire!
    AppointmentBooking.transaction do
      update(expires_at: DateTime.now - 1.hours)

      raise 'SlotExpiryFailed' unless DoctorSlot.find(doctor_slot_id).release(slot_number)
    end
  end

  def self.book!(props = {})
    AppointmentBooking.transaction do
      ab = AppointmentBooking.create({
        user_id: props[:user_id],
        doctor_id: props[:doctor_id],
        doctor_slot_id: props[:doctor_slot_id],
        slot_number: props[:slot_number],
        expires_at: props[:expires_at],
        amount_to_pay: props[:amount_to_pay],
        status: :booked
      })

      Rails.logger.error(ab.errors.full_messages)

      raise 'AppointmentBookingFailed' unless ab.valid?

      order = Razorpay::Order.create(
        amount: props[:amount_to_pay] * 1000,
        currency: 'INR',
        receipt: ab.id.to_s
      )

      p order.inspect
      raise 'PaymentFailedError' unless order.id.present?

      raise 'SomethingWentWrong' unless ab.update(status: :confirmed)

      raise 'SlotBookingFailed' unless DoctorSlot.find(props[:doctor_slot_id]).book(ab.slot_number)
    end
  end
end
