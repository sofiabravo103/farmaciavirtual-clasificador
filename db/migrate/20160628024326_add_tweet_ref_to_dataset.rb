class AddTweetRefToDataset < ActiveRecord::Migration
  def change
    add_reference :tweets, :dataset, foreign_key: true, index: true
  end
end
