class CreateKompanis < ActiveRecord::Migration[5.2]
  def change
    create_table :kompanis do |t|
      t.string :numri_fiskal
      t.string :numri_biznesit
      t.string :numri_tvsh
      t.string :kompania

      t.timestamps
    end
  end
end
