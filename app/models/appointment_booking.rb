class AppointmentBooking < ApplicationRecord
	include Bookable
    enum status: [:booked, :confirmed, :cancelled]

    validates :doctor_slot_id, :slot_number, presence: true


    def book!(props: {})
      AppointmentBooking.transaction do
        ab = AppointmentBooking.create!({
          user_id: props[:user_id],
          doctor_id: props[:doctor_id],
          doctor_slot_id: props[:doctor_slot_id],
          slot_number: props[:slot_number],
          expires_at: props[:expires_at],
          amount_to_pay: props[:amount_to_pay],
          status: 'booked',
        })

        raise 'SlotBookingFailed' unless DoctorSlot.find(props[:doctor_slot_id]).book(ab.slot_number)
      end
    end
end
