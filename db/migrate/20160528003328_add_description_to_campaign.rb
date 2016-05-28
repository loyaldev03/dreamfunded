class AddDescriptionToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :elevator_pitch, :text
    add_column :campaigns, :tags, :text
    add_column :campaigns, :about_campaign, :text
    add_column :campaigns, :employees_numer, :integer
  end
end
