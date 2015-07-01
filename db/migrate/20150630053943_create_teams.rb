class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
    	t.column :full_name, :string
    	t.column :image_name, :string
    	t.column :description, :string
    	#full bio will have redundant contents; will think later whether to fix
    	t.column :full_bio, :string
    end
  end
end
