class ResourcePresenter < BasePresenter
  presents :resource

  def name
    resource.name
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