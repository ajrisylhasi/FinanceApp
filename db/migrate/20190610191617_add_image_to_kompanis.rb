class AddImageToKompanis < ActiveRecord::Migration[5.2]
  def change
    add_column :kompanis, :image, :string
  end
end
