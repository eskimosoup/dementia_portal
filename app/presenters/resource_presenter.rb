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

  def postcode
    resource.postcode
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
    h.raw resource.summary
  end

  def description
    h.raw resource.description
  end

  def organisation_area
    return nil if organisation_name.nil?
    h.content_tag :div, class: "organisation-location" do
      h.concat(h.content_tag :span, organisation_name, class: "resource-organisation")
      h.concat(h.content_tag :span, "(#{ postcode })", class: "resource-postcode")
    end
  end

  def organisation_name
    resource.organisation_name
  end

  def categories_list
    return nil if resource_categories.nil?
    h.content_tag :ul, class: "resource-categories" do
      h.render partial: "categories/resource_category", collection: presented_resources, as: :category_presenter
    end
  end

  private

  def presented_resources
    BaseCollectionPresenter.new(collection: resource_categories,
                                view_template: view_template, presenter: CategoryPresenter)
  end

  def resource_categories
    @resource_categories ||= resource.categories
  end
end
