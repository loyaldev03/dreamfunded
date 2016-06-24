class AddDefaultToCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :video_link, :string, :default => "video link"
  end
end
