class AddCommentItToComment < ActiveRecord::Migration
  def change
    add_column :comments, :comment_id, :integer
    add_column :comments, :reply, :boolean
  end
end
