class CreateExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :explande_articles do |t|

      t.timestamps
    end
  end
end
