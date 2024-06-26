class CreateLabTestBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :lab_test_bookings do |t|
      t.integer :user_id, null: false, limit: 8
      t.integer :lab_id, null: false, limit: 8
      t.datetime :expires_at, null: false
      t.integer :amount_to_pay, null: false
      t.string :status, null: false # enum => 'booked', 'processing', 'completed', 'delivered'

      t.timestamps null: false
    end
  end
end
