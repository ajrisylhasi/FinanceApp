class CreateDestinims < ActiveRecord::Migration[5.2]
  def change
    create_table :destinims do |t|
      t.string :kodi
      t.string :pershkrimi

      t.timestamps
    end
  end
end
