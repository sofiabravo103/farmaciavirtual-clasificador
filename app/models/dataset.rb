class Dataset < ActiveRecord::Base
  has_many :tweets

  def annotated_tweets
    count = 0
    self.tweets.each {|t| count += 1 if t.annotation != nil}
    count
  end
end
