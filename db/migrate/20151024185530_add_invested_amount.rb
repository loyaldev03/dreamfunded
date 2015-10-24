class AddInvestedAmount < ActiveRecord::Migration
  def change
    add_column :users, :invested_amount, :integer, default: 0
  end
end
