class Tweet < ActiveRecord::Base
  belongs_to :dataset
  validates_inclusion_of :annotation, :in => [0, 1, 2, nil], on: :update

  def readable_annotation
    case self.annotation
    when 0
      return 'irrelevant'
    when 1
      return 'request'
    when 2
      return 'offer'
    end
  end
end
