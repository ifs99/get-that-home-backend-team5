class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :operation_type
      t.string :location
      t.integer :price
      t.string :property_type
      t.integer :maintanance
      t.integer :bathroom
      t.boolean :petfriendly
      t.integer :bedroom
      t.integer :area
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
