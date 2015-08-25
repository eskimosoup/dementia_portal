class SubCategoryPresenter < BasePresenter
  presents :sub_category

  delegate :resources, to: :sub_category, allow_nil: true

  def id
    sub_category.id
  end

  def title
    sub_category.name
  end

  def home_title
    h.raw "#{ title } <span>></span>"
  end

  def linked_title
    h.link_to sub_category, title: title do
      title
    end
  end

  def linked_home_title
    h.link_to sub_category, title: title do
      home_title
    end
  end

  def linked_homepage_image
    h.link_to sub_category, title: sub_category.title do
      h.image_tag sub_category.image.homepage, alt: title if sub_category.image?
    end
  end

  def show_image
    if sub_category.image?
      h.image_tag sub_category.image.show, alt: title, title: title
    else
      h.image_tag 'layout/content/placeholder-bg.jpg', alt: ''
    end
  end
end
