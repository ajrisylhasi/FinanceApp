class CreateGarancions < ActiveRecord::Migration[5.2]
  def change
    create_table :garancions do |t|

      t.timestamps
    end
  end
end
