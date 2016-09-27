class AddFundAmericaDefaultlToCompany < ActiveRecord::Migration

    change_column :companies, :fund_america_code, :text, default: ""

end
