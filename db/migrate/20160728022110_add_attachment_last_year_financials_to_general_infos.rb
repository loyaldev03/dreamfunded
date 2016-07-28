class AddAttachmentLastYearFinancialsToGeneralInfos < ActiveRecord::Migration
  def self.up
    change_table :general_infos do |t|
      t.attachment :last_year_financials
      t.attachment :last_2years_financials
      t.attachment :last_year_taxes
      t.attachment :cpa_review
      t.text :outstanding_loan
      t.text :financial_condition
    end
  end

  def self.down
    remove_attachment :general_infos, :last_year_financials
    remove_attachment :general_infos, :cpa_review
    remove_attachment :general_infos, :last_2years_financials
    remove_attachment :general_infos, :last_year_taxes
  end
end
