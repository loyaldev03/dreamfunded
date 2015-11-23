class CreateParagraph < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.column :page, :string
      t.column :title, :text
      t.column :content, :text
      t.column :position, :integer
    end
  end
end
