class CreateSubMbylljas < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_mbylljas do |t|
      t.references :sub, foreign_key: true
      t.references :mbyllja, foreign_key: true
      t.string :emertimi
      t.references :article, foreign_key: true
      t.float :pesha
      t.float :sasia

      t.timestamps
    end
  end
end
