class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.references :import, foreign_key: true
      t.references :export, foreign_key: true

      t.timestamps
    end
  end
end
