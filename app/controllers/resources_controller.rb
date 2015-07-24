class ResourcesController < ApplicationController
  def index
    @categories = Category.display.order(title: :asc).pluck(:title, :id)
  end

  def show

  end
end