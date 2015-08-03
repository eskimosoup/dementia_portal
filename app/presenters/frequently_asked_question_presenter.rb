class FrequentlyAskedQuestionPresenter < BasePresenter
  presents :frequently_asked_question

  def question
    frequently_asked_question.question
  end

  def answer
    h.raw frequently_asked_question.answer
  end
end