class CreateFundraiseTiers < ActiveRecord::Migration
  def change
    create_table :fundraise_tiers do |t|
        t.string  :amount
        t.text    :content
      t.timestamps
    end
  end
end
