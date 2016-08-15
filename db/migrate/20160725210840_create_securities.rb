class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :security_class
      t.string :amount
      t.string :outstanding
      t.boolean :voting_rights
      t.boolean :other_rights
      t.integer :general_info_id

      t.timestamps
    end
  end
end
