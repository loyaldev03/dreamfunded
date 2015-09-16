class ChangeDatatypeOnTeamFromStringToText < ActiveRecord::Migration
  def change
	  def up
	    change_column :teams, :fullbio, :text
	    change_column :teams, :summary, :text
	  end
  end
end
