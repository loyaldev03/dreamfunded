class AddTitleToFounders < ActiveRecord::Migration
  def change
    add_column :founders, :title, :string
  end
end
