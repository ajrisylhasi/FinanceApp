class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.string :nr_dud
      t.date :data
      

      t.timestamps
    end
  end
end
