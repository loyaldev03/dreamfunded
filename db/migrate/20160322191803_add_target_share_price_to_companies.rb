class AddTargetSharePriceToCompanies < ActiveRecord::Migration
  def change
  	  	add_column :companies, :suggested_target_price, :float
  end
end
