class FrequentlyAskedQuestionCategory < ActiveRecord::Base
  belongs_to :frequently_asked_question
  belongs_to :category

  validates :frequently_asked_question, :category, presence: true
end
