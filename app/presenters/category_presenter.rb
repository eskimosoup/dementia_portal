class CategoryPresenter < BasePresenter
  presents :category

  def title
    h.raw "#{category.title} <span>></span>"
  end

  def homepage_image
    h.image_tag category.image.homepage, alt: title if category.image?
  end
end
