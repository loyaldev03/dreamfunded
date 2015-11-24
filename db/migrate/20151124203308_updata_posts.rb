class UpdataPosts < ActiveRecord::Migration
  def change
    add_column :posts, :position, :integer, default: 0
    add_column :posts, :page, :string
  end
end
