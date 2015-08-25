module Optimadmin
  class SubCategoryPresenter < Optimadmin::BasePresenter
    presents :sub_category

    def name
      sub_category.name
    end

    def category
      sub_category.category_title
    end
  end
end