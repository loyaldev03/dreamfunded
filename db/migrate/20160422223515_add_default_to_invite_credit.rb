class AddDefaultToInviteCredit < ActiveRecord::Migration
  def change
    change_column :users, :credit, :integer, :default => 0
    change_column :users, :invite_credit, :integer, :default => 0
  end
end
