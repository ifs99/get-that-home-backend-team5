class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.boolean :favorite
      t.boolean :contacted
      t.references :property, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :actived
      t.boolean :closed

      t.timestamps
    end
  end
end
