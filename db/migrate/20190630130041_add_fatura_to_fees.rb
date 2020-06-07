class AddFaturaToFees < ActiveRecord::Migration[5.2]
  def change
    add_reference :fees, :fatura, foreign_key: true
  end
end
