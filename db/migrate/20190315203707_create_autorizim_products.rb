class CreateAutorizimProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :autorizim_products do |t|
      t.references :autorizim, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
