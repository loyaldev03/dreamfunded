class AddSecuritiesReservedToSecurities < ActiveRecord::Migration
  def change
    add_column :securities, :securities_reserved, :string
  end
end
