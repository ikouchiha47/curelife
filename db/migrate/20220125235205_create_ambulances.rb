class CreateAmbulances < ActiveRecord::Migration[7.0]
  def change
    create_table :ambulances do |t|
      t.string :vehicle_number, null: false, unique: true
      t.boolean :booked
      t.boolean :blocked, null: false, default: true
      t.timestamps null: false
    end
  end
end
