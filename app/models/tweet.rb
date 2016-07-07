class Tweet < ActiveRecord::Base
  belongs_to :dataset

  def readable_annotation
    case self.annotation
    when 0
      return 'irrelevant'
    when 1
      return 'requesting'
    when 2
      return 'offering'
    end
  end
end
