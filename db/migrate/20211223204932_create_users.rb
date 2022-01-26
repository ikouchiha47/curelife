class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :type, null: false
      t.string :salutation, null: false
      t.string :name, null: false
      t.string :country_code
      t.string :phone
      t.string :email
      t.datetime :birthdate, null: false

      t.boolean :blocked, default: false

      t.string :designation_slugs
      t.timestamps null: false
    end
  end
end
