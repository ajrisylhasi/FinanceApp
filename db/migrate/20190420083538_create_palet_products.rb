class CreatePaletProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :palet_products do |t|
      t.references :palet, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :sasia

      t.timestamps
    end
  end
end
