module Optimadmin
  class CategoryPresenter < Optimadmin::BasePresenter
    presents :category

    def title
      category.title
    end
  end
end