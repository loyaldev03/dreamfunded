class AddUsersReferenceToPlaidAccounts < ActiveRecord::Migration
  def change
    add_reference :plaid_accounts, :user, index: true
  end
end
