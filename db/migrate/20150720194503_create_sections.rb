class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.column :company_id, :integer
      t.column :overview, :string
      t.column :target_market, :string
      t.column :current_investor_details, :string
      t.column :detailed_metrics, :string
      t.column :customer_testimonials, :string
      t.column :competitive_landscape, :string
      t.column :planned_use_of_funds, :string
      t.column :pitch_deck, :string

      t.timestamps
    end
  end
end
