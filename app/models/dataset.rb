class Dataset < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  belongs_to :user

  def annotated_tweets
    self.tweets.where.not(annotation: nil)
  end

  def get_unannotated_tweet
    self.tweets.shuffle.each do |t|
      return t if t.annotation == nil
    end
    return nil
  end

  def progress
    self.annotated_tweets.size * 100 / self.tweets.size
  end

end
