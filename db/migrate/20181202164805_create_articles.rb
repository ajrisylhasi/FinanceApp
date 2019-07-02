class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :pershkrimi
      t.integer :tarif_kodi
      t.timestamps
    end
  end
end
