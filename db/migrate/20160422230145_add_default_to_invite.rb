class AddDefaultToInvite < ActiveRecord::Migration
  def change
    change_column :invites, :status, :string, :default => "Hasn't signed up yet"
  end
end
