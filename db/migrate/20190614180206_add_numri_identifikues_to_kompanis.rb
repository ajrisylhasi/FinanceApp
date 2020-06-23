class AddNumriIdentifikuesToKompanis < ActiveRecord::Migration[5.2]
  def change
    add_column :kompanis, :numri_identifikues, :string
  end
end
