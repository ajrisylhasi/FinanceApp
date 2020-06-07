class CreateMbylljas < ActiveRecord::Migration[5.2]
  def change
    create_table :mbylljas do |t|
      t.string :nr_mbylljes
      t.date :data
      t.timestamps
    end
  end
end
