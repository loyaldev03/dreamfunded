class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.column :company_id, :integer
      t.column :name, :string
      t.timestamps
    end
  end
end
