class CreatePlaidAccounts < ActiveRecord::Migration
  def change
    create_table :plaid_accounts do |t|
      t.string :access_token
      t.string :token
      t.string :plaid_type
      t.string :name
      t.string :bank_name
      t.integer :number
      t.string :plaid_id
      t.string :owner_type
      t.string :owner_id
      t.datetime :last_sync
      t.decimal :current_balance
      t.decimal :available_balance
      t.string :error

      t.timestamps
    end
  end
end
