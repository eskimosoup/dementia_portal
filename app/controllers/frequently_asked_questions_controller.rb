class FrequentlyAskedQuestionsController < ApplicationController
  def index
    @categories = Category.displayed
  end
end
