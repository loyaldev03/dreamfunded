class AddAcceptedToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :accepted, :boolean
    add_column :invites, :signedup, :boolean
  end
end
