class CreateLabs < ActiveRecord::Migration[7.0]
  def change
    create_table :labs do |t|
      t.text :name, null: false
      t.text :address
      t.integer :location_id, null: false, limit: 8

      t.timestamps null: false
    end
  end
end
