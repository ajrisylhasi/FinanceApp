class CreateFaturas < ActiveRecord::Migration[5.2]
  def change
    create_table :faturas do |t|
      t.string :nr_fatures
      t.date :data
      t.references :export, foreign_key: true

      t.timestamps
    end
  end
end
