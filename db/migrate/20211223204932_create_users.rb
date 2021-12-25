class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :country_code
      t.string :phone
      t.boolean :blocked, default: false
      t.datetime :birthdate, null: false
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
