class AddProductsToNormatives < ActiveRecord::Migration[5.2]
  def change
    add_reference :normatives, :product, foreign_key: true
  end
end
