class AddLocationToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :location, :string, array: true
  end
end
