class Tweet < ActiveRecord::Base
  belongs_to :dataset

  def readable_annotation
    case self.annotation
    when 0
      return 'irrelevant'
    when 1
      return 'request'
    when 2
      return 'offer'
    else
      return ''
    end
  end
end
