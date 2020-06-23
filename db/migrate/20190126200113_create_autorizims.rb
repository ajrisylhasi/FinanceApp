class CreateAutorizims < ActiveRecord::Migration[5.2]
  def change
    create_table :autorizims do |t|

      t.timestamps
    end
  end
end
