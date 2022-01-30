class AlterAppointmentBookingsAddSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :appointment_bookings,
      :doctor_slot_id, :integer, limit: 8, null: false
  
    add_column :appointment_bookings,
      :slot_number, :integer, null: false
  end
end
