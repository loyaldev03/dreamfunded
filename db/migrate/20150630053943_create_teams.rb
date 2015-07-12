class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
    	t.column :name, :string
    	t.column :file_name, :string
    	t.column :summary, :string
    	t.column :fullbio, :string
    end
  end
end
