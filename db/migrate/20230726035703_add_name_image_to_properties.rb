class AddNameImageToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :name_image, :string, array: true
  end
end
