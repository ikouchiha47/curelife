class AddCordinatesToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :coordinates, :string
  end
end
