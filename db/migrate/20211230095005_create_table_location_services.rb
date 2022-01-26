class CreateTableLocationServices < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :city, null: false
      t.string :state_code, null: false
      t.string :zip_code, null: false
      t.string :coordinates

      t.timestamps null: false
    end

    create_table :location_services do |t|
      t.references :location
      t.string :services

      t.timestamps null: false
    end

    add_index :locations, [:zip_code, :state_code], unique: true
  end
end
