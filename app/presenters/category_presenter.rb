class CategoryPresenter < BasePresenter
  presents :category

  delegate :resources, to: :category, allow_nil: true
  delegate :sub_category_ids, to: :category

  def id
    category.id
  end

  def title
    category.title
  end

  def home_title
    h.raw "#{ title } <span>></span>"
  end

  def linked_title
    h.link_to category, title: title do
      title
    end
  end

  def linked_home_title
    h.link_to category, title: title do
      home_title
    end
  end

  def linked_homepage_image
    h.link_to category, title: category.title do
      h.image_tag category.image.homepage, alt: title if category.image?
    end
  end

  def show_image
    if category.image?
      h.image_tag category.image.show, alt: title, title: title
    else
      h.image_tag 'layout/content/placeholder-bg.jpg', alt: ''
    end
  end
end
