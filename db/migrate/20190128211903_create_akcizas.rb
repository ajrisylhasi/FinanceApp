class CreateAkcizas < ActiveRecord::Migration[5.2]
  def change
    create_table :akcizas do |t|
      t.string :lloji

      t.timestamps
    end
  end
end
