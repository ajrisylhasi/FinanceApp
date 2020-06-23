class CreateSubexpls < ActiveRecord::Migration[5.2]
  def change
    create_table :subexpls do |t|
      t.references :import, foreign_key: true
      t.references :exportlande, foreign_key: true
      t.references :import_gjendja, foreign_key: true
      t.float :sasia
      t.float :pesha
      t.float :qmimi

      t.timestamps
    end
  end
end
