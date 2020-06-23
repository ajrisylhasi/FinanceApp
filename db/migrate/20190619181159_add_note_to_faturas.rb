class AddNoteToFaturas < ActiveRecord::Migration[5.2]
  def change
    add_column :faturas, :note, :text
  end
end
