class CreateImportGjendjas < ActiveRecord::Migration[5.2]
  def change
    create_table :import_gjendjas do |t|

      t.timestamps
    end
  end
end
