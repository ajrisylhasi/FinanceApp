class AddQmimiToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :qmimi, :float
  end
end
