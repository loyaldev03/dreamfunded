class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :safe_cap
      t.string :valuation_cap
      t.string :investor_threshold
      t.boolean :pro_rata?
      t.string :governing_law_state
      t.integer :days
      t.string :raised_this_round
      t.integer :discount
      t.integer :store_credit
      t.integer :store_discount
      t.integer :general_info_id

      t.timestamps
    end
  end
end
