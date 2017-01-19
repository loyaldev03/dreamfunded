class AddCeoToPrincipalHelolder < ActiveRecord::Migration
  def change
    add_column :general_infos, :ceo, :string
  end
end
