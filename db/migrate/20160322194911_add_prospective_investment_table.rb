class AddProspectiveInvestmentTable < ActiveRecord::Migration
  def change
  	create_table :prospective_investments do |t|
  		t.string  :user_id
    	t.string  :first_name
    	t.string  :last_name
    	t.string  :email
    	t.string  :phone
    	t.string  :company
    	t.string  :company_id
		  t.string  :investment_amount
    	t.float   :shares_price
    	t.string  :message
    	t.timestamps
    end
  end
end
