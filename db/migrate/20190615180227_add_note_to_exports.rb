class AddNoteToExports < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :note, :text
  end
end
