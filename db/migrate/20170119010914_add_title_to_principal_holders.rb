class AddTitleToPrincipalHolders < ActiveRecord::Migration
  def change
    add_column :principal_holders, :title, :string
  end
end
