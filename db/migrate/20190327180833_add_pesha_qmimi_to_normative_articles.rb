class AddPeshaQmimiToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :pesha_qmimi, :string
  end
end
