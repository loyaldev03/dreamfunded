class ChangeDatatypeOnTeamFromStringToText < ActiveRecord::Migration
  def change
	  def up
	    change_column :team, :fullbio, :text, :limit => nil
	  end

	  def down
	    change_column :team, :fullbio, :string
	  end
  end
end
