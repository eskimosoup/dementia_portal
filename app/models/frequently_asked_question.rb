class FrequentlyAskedQuestion < ActiveRecord::Base

  has_many :frequently_asked_question_categories, dependent: :destroy
  has_many :categories, through: :frequently_asked_question_categories

  validates :question, :answer, presence: true

end
