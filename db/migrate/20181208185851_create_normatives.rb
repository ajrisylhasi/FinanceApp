class CreateNormatives < ActiveRecord::Migration[5.2]
  def change
    create_table :normatives do |t|
      t.integer :nr_normatives

      t.timestamps
    end
  end
end
