class ResourcesController < ApplicationController
  def index
    @resource_search = ResourceSearch.new(params.fetch(:resource_search, {}).delete_if{|k,v| v.blank? })
    @presented_resources = BaseCollectionPresenter.new(collection: @resource_search.resources, view_template: view_context, presenter: ResourcePresenter)
  end

  def show
    resource = Resource.friendly.find(params[:id])
    @presented_resource = ResourcePresenter.new(object: resource, view_template: view_context)
    @same_organisation_resources = BaseCollectionPresenter.new(collection: Resource.where(organisation_id: resource.organisation_id), view_template: view_context, presenter: ResourcePresenter)
  end
end