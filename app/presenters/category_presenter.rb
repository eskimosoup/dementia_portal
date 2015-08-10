class CategoryPresenter < BasePresenter
  presents :category

  def title
    h.raw "#{category.title} <span>></span>"
  end

  def linked_title
    h.link_to category, title: category.title do
      title
    end
  end

  def linked_homepage_image
    h.link_to category, title: category.title do
      h.image_tag category.image.homepage, alt: title if category.image?
    end
  end
end
