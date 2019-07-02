class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :kompania
      t.string :shteti
      t.string :qyteti
      t.string :adresa
      t.string :numri_tel
      t.string :numri_fiskal
      t.string :numri_biz
      t.string :numri_tvsh
      t.string :konsignacioni
      t.string :shteti_k
      t.string :qyteti_k
      t.string :adresa_k
      t.string :numri_tel_k

      t.timestamps
    end
  end
end
