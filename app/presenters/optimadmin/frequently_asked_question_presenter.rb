module Optimadmin
  class FrequentlyAskedQuestionPresenter < Optimadmin::BasePresenter
    presents :frequently_asked_question

    def question
      frequently_asked_question.question
    end
  end
end