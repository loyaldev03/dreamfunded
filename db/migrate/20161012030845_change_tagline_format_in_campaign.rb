class ChangeTaglineFormatInCampaign < ActiveRecord::Migration
  def change
     change_column :campaigns, :tagline, :text
  end
end
