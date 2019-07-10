class AddExplToFaturas < ActiveRecord::Migration[5.2]
  def change
    add_reference :faturas, :exportlande, foreign_key: true
  end
end
