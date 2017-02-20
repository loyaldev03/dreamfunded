class AddSelectedBankAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :selected_bank_account, :text
  end
end
