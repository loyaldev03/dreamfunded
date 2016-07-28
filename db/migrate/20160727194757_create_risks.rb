class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
        t.text :content

      t.timestamps
    end
  end
end
