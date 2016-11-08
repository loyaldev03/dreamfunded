class AddAdvisorToUser < ActiveRecord::Migration
  def change
    add_column :users, :advisor, :boolean
  end
end
