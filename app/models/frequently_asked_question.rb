class FrequentlyAskedQuestion < ActiveRecord::Base

  has_many :frequently_asked_question_categories, dependent: :destroy
  has_many :categories, through: :frequently_asked_question_categories

  scope :categories, ->(category_ids) { joins(:categories).where(categories: { id: category_ids }).merge(Category.displayed) if category_ids }
  scope :displayed, ->{ where(display: true) }

  validates :question, :answer, presence: true

end
