class AddSourceUrlToNews < ActiveRecord::Migration
  def change
    add_column :news, :source_url, :string
  end
end
