class AddArticleNameToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :article_name, :string
  end
end
