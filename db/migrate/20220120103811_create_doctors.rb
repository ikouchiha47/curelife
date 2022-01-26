class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :specialities do |t|
      t.string :name, null: false
      t.string :slug, null: false
    end

    create_table :doctors do |t|
      t.string :salutation, null: false
      t.string :name, null: false
      t.string :country_code
      t.string :phone
      t.string :email, null: false
      t.datetime :birthdate, null: false

      t.boolean :blocked, default: false

      t.string :password_digest, null: false, default: ""
      t.string :designation_slugs
      t.string :years_experience, null: false, default: 0
 
      t.string :speciality_ids
      t.string :location_ids, null: false
      t.string :registration_number, null: false
      t.timestamps null: false
    end

    # add_index :doctors, [:country_code, :phone]
    add_index :doctors, :email, unique: true
    add_index :doctors, :registration_number, unique: true
    add_index :specialities, :slug, unique: true
  end
end
