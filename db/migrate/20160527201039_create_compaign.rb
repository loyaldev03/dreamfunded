class CreateCompaign < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer  :company_id
      t.integer  :funding_goal
      t.string  :tagline
      t.string  :category
    end
  end
end
