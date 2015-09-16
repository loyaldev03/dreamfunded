class ChangeDatatypeOnTeamFromStringToText < ActiveRecord::Migration
  def change
	  def up
	    change_column :team, :fullbio, :text
	  end
  end
end
