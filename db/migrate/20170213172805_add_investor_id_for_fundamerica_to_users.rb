class AddInvestorIdForFundamericaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :investor_id_for_fundamerica, :string
  end
end
