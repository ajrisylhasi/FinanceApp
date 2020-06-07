class AddStuffToNormatives < ActiveRecord::Migration[5.2]
  def change
    add_column :normatives, :data, :date
    add_column :normatives, :attachment, :text
  end
end
