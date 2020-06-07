class AddBankStuffToKompanis < ActiveRecord::Migration[5.2]
  def change
    add_column :kompanis, :bank_account, :string
    add_column :kompanis, :bank, :string
    add_column :kompanis, :account_holder, :string
    add_column :kompanis, :corresponding_bank, :string
    add_column :kompanis, :swift_code, :string
  end
end
