class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.column :company_id, :integer
      t.column :overview, :text
      t.column :target_market, :text
      t.column :current_investor_details, :text
      t.column :detailed_metrics, :text
      t.column :customer_testimonials, :text
      t.column :competitive_landscape, :text
      t.column :planned_use_of_funds, :text
      t.column :pitch_deck, :text

      t.timestamps
    end
  end
end
