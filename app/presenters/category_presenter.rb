class CategoryPresenter < BasePresenter
  presents :category

  def title
    category.title
  end
end