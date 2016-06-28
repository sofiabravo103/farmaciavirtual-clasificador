class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.integer :annotation
      t.timestamps null: false
    end
  end
end
