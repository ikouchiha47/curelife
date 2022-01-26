class CreateAppointmentBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_bookngs do |t|
      t.integer :user_id, null: false
      t.integer :doctor_id, null: false
      t.datetime :expires_at, null: false
      t.integer :amount_to_pay, null: false
      t.string :status, null: false # enum => "confirmed", "cancelled", "completed"
      t.timestamps null: false
    end
  end
end
