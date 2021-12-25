class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :bookable, polymorphic: true

      t.string :uuid, null: false      
      t.string :patient_id
      t.datetime :booking_time, null: false
      t.string :status, null: false
      t.text :description
      t.text :metadata
      t.timestamps null: false
    end

    add_index :bookable, [:bookable_type, :bookable_id]
  end
end
