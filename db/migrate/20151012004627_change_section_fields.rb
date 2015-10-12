class ChangeSectionFields < ActiveRecord::Migration
  def change
    change_column :sections, :overview, :text
    change_column :sections, :target_market, :text
    change_column :sections, :current_investor_details, :text
    change_column :sections, :detailed_metrics, :text
    change_column :sections, :customer_testimonials, :text
    change_column :sections, :competitive_landscape, :text
    change_column :sections, :planned_use_of_funds, :text
    change_column :sections, :pitch_deck, :text
  end
end






