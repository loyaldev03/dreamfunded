class CreateDocusign < ActiveRecord::Migration
  def change
    create_table :docusigns do |t|
      t.column :envelope_id, :integer
      t.column :user_id, :integer
      t.column :company_id, :integer
    end
  end
end
