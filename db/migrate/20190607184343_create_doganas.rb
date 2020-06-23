class CreateDoganas < ActiveRecord::Migration[5.2]
  def change
    create_table :doganas do |t|
      t.string :kodi
      t.string :pershkrimi

      t.timestamps
    end
  end
end
