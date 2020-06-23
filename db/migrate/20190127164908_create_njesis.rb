class CreateNjesis < ActiveRecord::Migration[5.2]
  def change
    create_table :njesis do |t|
      t.string :lloji

      t.timestamps
    end
  end
end
