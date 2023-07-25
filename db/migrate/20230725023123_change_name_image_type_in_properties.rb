class ChangeNameImageTypeInProperties < ActiveRecord::Migration[7.0]
  def change
    change_column :properties, :name_image, :string, array: true, default: [] , using: "(string_to_array(name_image, ','))"
  end
end
