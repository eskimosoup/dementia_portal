class ResourcesController < ApplicationController
  def index
    @resource_search = ResourceSearch.new(params.fetch(:resource_search, {}).delete_if{|k,v| v.blank? })
    @presented_resources = BaseCollectionPresenter.new(collection: @resource_search.resources, view_template: view_context, presenter: ResourcePresenter)
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.categories(@resource_search.category_ids_no_blanks)
                                                  .id_not(@presented_resources.map(&:id)), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(@resource_search.category_ids_no_blanks).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    resource = Resource.friendly.find(params[:id])
    @presented_resource = ResourcePresenter.new(object: resource, view_template: view_context)
    @presented_same_organisation_resources = BaseCollectionPresenter.new(collection: Resource.organisation(resource.organisation_id).id_not(resource.id),
                                                                         view_template: view_context, presenter: ResourcePresenter)
    resources_already_loaded = @presented_same_organisation_resources.map(&:id) << resource.id
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.categories(resource.category_ids)
                                  .id_not(resources_already_loaded), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(resource.category_ids).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
    @presented_frequently_asked_questions = BaseCollectionPresenter.new(collection: FrequentlyAskedQuestion.displayed.categories(resource.category_ids).limit(3),
                                                      view_template: view_context, presenter: FrequentlyAskedQuestionPresenter)
  end
end