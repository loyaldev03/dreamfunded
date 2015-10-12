class ChangeTeamFieldsToText < ActiveRecord::Migration
  def change
    change_column :teams, :summary, :text
    change_column :teams, :fullbio, :text
  end
end
