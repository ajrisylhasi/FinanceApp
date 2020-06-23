class AddMbetjaQmimiToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :mbetja_qmimi, :float
  end
end
