class AlterTableUniquePhoneAndType < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:country_code, :phone, :type]
  end
end
