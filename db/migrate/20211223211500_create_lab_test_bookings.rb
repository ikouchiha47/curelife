class CreateLabTestBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :lab_test_bookings do |t|
      t.integer :lab_id, null: false
      t.datetime :expires_at, null: false
      t.integer :amount_to_pay, null: false
      t.string :status, null: false # enum => 'booked', 'processing', 'completed', 'delivered'

      t.timestamps
    end
  end
end
