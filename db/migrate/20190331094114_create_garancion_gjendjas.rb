class CreateGarancionGjendjas < ActiveRecord::Migration[5.2]
  def change
    create_table :garancion_gjendjas do |t|
      t.references :garancion, foreign_key: true
      t.references :import_gjendja, foreign_key: true

      t.timestamps
    end
  end
end
