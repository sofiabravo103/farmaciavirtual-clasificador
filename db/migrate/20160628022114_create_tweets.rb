class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.integer :clasification
      t.timestamps null: false
    end
  end
end
