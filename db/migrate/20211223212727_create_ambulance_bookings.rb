class CreateAmbulanceBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :ambulance_bookings do |t|
      t.integer :user_id
      t.integer :ambulance_id, null: false
      t.text :destination, null: false
      t.text :origin, null: false
      t.integer :amount_to_pay, null: false
      t.string :status, null: false # enum => "booked", "cancelled", "completed"
      t.timestamps null: false
    end
  end
end
