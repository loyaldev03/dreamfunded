class CreateCampaignEvents < ActiveRecord::Migration
  def change
    create_table :campaign_events do |t|
      t.string :state
      t.belongs_to :campaign
       t.timestamps
    end
     add_index :campaign_events, :campaign_id
  end
end
