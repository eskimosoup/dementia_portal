class CategoryPresenter < BasePresenter
  presents :category

  def title
    category.title
  end

  def homepage_image
    h.image_tag category.image.homepage, alt: title if category.image?
  end
end