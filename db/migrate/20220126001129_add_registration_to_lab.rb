class AddRegistrationToLab < ActiveRecord::Migration[7.0]
  def change
    add_column :labs, :registration_number, :string, null: false
    add_column :labs, :blacklisted, :boolean, null: false, default: false
    add_index :labs, :registration_number, unique: true
  end
end
