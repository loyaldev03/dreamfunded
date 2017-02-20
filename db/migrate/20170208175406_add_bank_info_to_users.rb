class AddBankInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bank_info, :text
  end
end
