class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
    	t.column :name, :string
    	t.column :file_name, :string
    	t.column :summary, :text
    	t.column :fullbio, :text
    end
  end
end
