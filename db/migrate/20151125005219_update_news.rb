class UpdateNews < ActiveRecord::Migration
  def change
    add_column :news, :video_link, :string
  end
end
