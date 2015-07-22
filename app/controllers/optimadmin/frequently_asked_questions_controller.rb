module Optimadmin
  class FrequentlyAskedQuestionsController < Optimadmin::ApplicationController
    before_action :set_frequently_asked_question, only: [:show, :edit, :update, :destroy]

    def index
      @frequently_asked_questions = Optimadmin::BaseCollectionPresenter.new(collection: FrequentlyAskedQuestion.where('question LIKE ?', "#{params[:search]}").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::FrequentlyAskedQuestionPresenter)
    end

    def show
    end

    def new
      @frequently_asked_question = FrequentlyAskedQuestion.new
    end

    def edit
    end

    def create
      @frequently_asked_question = FrequentlyAskedQuestion.new(frequently_asked_question_params)
      if @frequently_asked_question.save
        redirect_to frequently_asked_questions_url, notice: 'Frequently asked question was successfully created.'
      else
        render :new
      end
    end

    def update
      if @frequently_asked_question.update(frequently_asked_question_params)
        redirect_to frequently_asked_questions_url, notice: 'Frequently asked question was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @frequently_asked_question.destroy
      redirect_to frequently_asked_questions_url, notice: 'Frequently asked question was successfully destroyed.'
    end

  private


    def set_frequently_asked_question
      @frequently_asked_question = FrequentlyAskedQuestion.find(params[:id])
    end

    def frequently_asked_question_params
      params.require(:frequently_asked_question).permit(:question, :answer, :display)
    end
  end
end
