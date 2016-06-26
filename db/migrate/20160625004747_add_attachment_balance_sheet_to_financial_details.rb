class AddAttachmentBalanceSheetToFinancialDetails < ActiveRecord::Migration
  def self.up
    change_table :financial_details do |t|
      t.attachment :balance_sheet
      t.attachment :income_statements
      t.attachment :statement_of_cash_flow
      t.attachment :statement_changes_of_equity
      t.attachment :business_plan
      t.attachment :party_transaction
      t.attachment :intended_use_of_proceeds
      t.attachment :capital_structure
      t.attachment :material_terms
      t.attachment :financial_conditions
      t.attachment :directors_background
      t.attachment :accountant_review
    end
  end

  def self.down
    remove_attachment :financial_details, :balance_sheet
    remove_attachment :financial_details, :income_statements
    remove_attachment :financial_details, :statement_of_cash_flow
    remove_attachment :financial_details, :statement_changes_of_equity
    remove_attachment :financial_details, :business_plan
    remove_attachment :financial_details, :party_transaction
    remove_attachment :financial_details, :intended_use_of_proceeds
    remove_attachment :financial_details, :capital_structure
    remove_attachment :financial_details, :material_terms
    remove_attachment :financial_details, :financial_conditions
    remove_attachment :financial_details, :directors_background
    remove_attachment :financial_details, :accountant_review
  end
end
