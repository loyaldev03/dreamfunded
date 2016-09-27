class AddFundAmericaUrlToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :fund_america_code, :text
  end
end
