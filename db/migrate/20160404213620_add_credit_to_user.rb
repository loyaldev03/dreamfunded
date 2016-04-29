class AddCreditToUser < ActiveRecord::Migration
  def change
    add_column :users, :credit, :integer
  end
end
