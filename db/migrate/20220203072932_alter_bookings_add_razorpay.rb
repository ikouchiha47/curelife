class AlterBookingsAddRazorpay < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :uuid, :string, null: false
    remove_column :bookings, :patient_id, :string, null: false
    remove_column :bookings, :description, :text, null: false
    remove_column :bookings, :booking_time, :datetime, null: false

    add_column :bookings, :razorpay_id, :string
    add_column :bookings, :doctor_id, :bigint
    add_column :bookings, :user_id, :bigint

    add_index :bookings, [:doctor_id, :user_id]
  end
end
