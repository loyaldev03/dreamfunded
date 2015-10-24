class CreateInvestment < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.belongs_to :company, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
