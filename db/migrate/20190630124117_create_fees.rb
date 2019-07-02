class CreateFees < ActiveRecord::Migration[5.2]
  def change
    create_table :fees do |t|
      t.string :pershkrimi
      t.float :sasia
      t.float :pesha
      t.float :qmimi

      t.timestamps
    end
  end
end
