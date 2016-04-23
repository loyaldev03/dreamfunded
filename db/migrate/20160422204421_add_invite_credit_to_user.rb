class AddInviteCreditToUser < ActiveRecord::Migration
  def change
    add_column :users, :invite_credit, :integer
  end
end
