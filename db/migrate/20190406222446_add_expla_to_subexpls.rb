class AddExplaToSubexpls < ActiveRecord::Migration[5.2]
  def change
    add_reference :subexpls, :explande_article, foreign_key: true
  end
end
