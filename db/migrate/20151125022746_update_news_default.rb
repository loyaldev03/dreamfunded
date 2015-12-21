class UpdateNewsDefault < ActiveRecord::Migration
  def change
    change_column :news, :video_link, :string, default: ''
  end
end
