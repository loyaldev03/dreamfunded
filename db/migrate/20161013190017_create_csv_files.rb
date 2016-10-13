class CreateCsvFiles < ActiveRecord::Migration
  def change
    create_table :csv_files do |t|
        t.integer :user_id
        t.attachment :file
        t.timestamps
    end
  end
end
