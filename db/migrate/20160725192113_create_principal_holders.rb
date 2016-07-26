class CreatePrincipalHolders < ActiveRecord::Migration
  def change
    create_table :principal_holders do |t|
      t.string :name
      t.text :securities_held
      t.string :voting_power
      t.integer :general_info_id

      t.timestamps
    end
  end
end
