class ChangeDefaultValueYoutube < ActiveRecord::Migration
  def change
    change_column :companies, :video_link, :string, :default => ""
  end
end
