class Dataset < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  belongs_to :user

  def annotated_tweets
    count = 0
    self.tweets.each {|t| count += 1 if t.annotation != nil}
    count
  end

  def get_unannotated_tweet
    self.tweets.shuffle.each do |t|
      return t if t.annotation == nil
    end
  end
end
