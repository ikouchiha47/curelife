class CreateDoctorSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_slots do |t|
      t.integer :doctor_id, null: false, limit: 8
      t.integer :location_id, null: false, limit: 8
      t.string :days_of_week, null: false, default: "0000000"
      t.integer :checkup_duration, null: false
      t.text :slot_template, null: false, default: "{}"
      t.text :bookings, null: false, default: ""
      t.timestamps null: false
    end

    add_index :doctor_slots, [:doctor_id, :location_id]
  end
end

=begin
   slot_template => {
     430: 450,
     455: 510,
     515: 535,
     1715:1735
   }

   bookings = "0" * len(slot_template)
=end
