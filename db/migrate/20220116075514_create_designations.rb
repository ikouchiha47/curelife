class CreateDesignations < ActiveRecord::Migration[7.0]
  def change
    create_table :designations do |t|
      t.string :title, null: false
      t.string :slug, null: false
    end
  end
end
