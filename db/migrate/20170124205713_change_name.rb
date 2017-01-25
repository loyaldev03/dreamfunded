class ChangeName < ActiveRecord::Migration
  def change
    rename_column :general_infos, :transaction, :transactin
    change_column :general_infos, :material_capital, :text
  end
end
