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