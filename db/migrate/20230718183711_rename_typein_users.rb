class RenameTypeinUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :type, :type_user
  end
end
