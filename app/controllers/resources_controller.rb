class ResourcesController < ApplicationController
  before_action :resource_search

  def index
    @resource_search = ResourceSearch.new(params.fetch(:resource_search, {}).delete_if{|k,v| v.blank? })
    @resources = @resource_search.resources.order(:name).page(params[:page]).per(params[:per_page] || 10)
    @presented_resources = BaseCollectionPresenter.new(collection: @resources, view_template: view_context, presenter: ResourcePresenter)
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.sub_categories(@resource_search.sub_category_ids_no_blanks)
                                                  .id_not(@presented_resources.map(&:id)).limit(5), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(@resource_search.category_ids).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    resource = Resource.friendly.find(params[:id])
    @presented_resource = ResourcePresenter.new(object: resource, view_template: view_context)
    if resource.organisation
      @presented_organisation = OrganisationPresenter.new(object: resource.organisation, view_template: view_context)
    end
    @presented_same_organisation_resources = BaseCollectionPresenter.new(collection: Resource.organisation(resource.organisation_id).id_not(resource.id).limit(5),
                                                                         view_template: view_context, presenter: ResourcePresenter)
    resources_already_loaded = @presented_same_organisation_resources.map(&:id) << resource.id
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.sub_categories(resource.sub_category_ids)
                                  .id_not(resources_already_loaded).limit(5), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(resource.category_ids).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
    @presented_frequently_asked_questions = BaseCollectionPresenter.new(collection: FrequentlyAskedQuestion.displayed.categories(resource.category_ids).limit(3),
                                                      view_template: view_context, presenter: FrequentlyAskedQuestionPresenter)
  end

  private

    def resource_search
      @resource_search = ResourceSearch.new(params.fetch(:resource_search, {}).delete_if{|k,v| v.blank? })
    end
end
