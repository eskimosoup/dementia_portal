class ResourcePresenter < BasePresenter
  presents :resource

  delegate :to_model, to: :resource

  def id
    resource.id
  end

  def name
    resource.name
  end

  def distance
    return nil if !resource.respond_to?(:distance)
    h.content_tag :div, class: "distance right" do
      "#{ h.number_with_precision(resource.distance, precision: 2) } miles"
    end
  end

  def hero_image
    if resource.categories.first.image.present?
       h.image_tag resource.categories.first.image.show, alt: ''
    else
      h.image_tag 'layout/content/placeholder-bg.jpg', alt: ''
    end
  end

  def categories
    resource.categories.map{|x| x.title }.join(', ')
  end

  def linked_name
    h.link_to name, resource
  end

  def summary
    resource.summary
  end

  def description
    h.raw resource.description
  end

  def organisation_name
    resource.organisation_name
  end
end
