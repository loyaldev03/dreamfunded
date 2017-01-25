class RemoveAttachmentsFromGeneralInfos < ActiveRecord::Migration
  def change
    remove_attachment :general_infos, :last_year_financials
    remove_attachment :general_infos, :cpa_review
    remove_attachment :general_infos, :last_2years_financials
    remove_attachment :general_infos, :last_year_taxes
  end
end
