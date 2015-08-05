class TargetGroupsController < ApplicationController
  def show
    @target_group = TargetGroup.friendly.find(params[:id])
    @resource_search = ResourceSearch.new({ target_group_ids: @target_group.id })
    @presented_resources = BaseCollectionPresenter.new(collection: @resource_search.resources, view_template: view_context, presenter: ResourcePresenter)
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.categories(@resource_search.category_ids_no_blanks)
                                                  .id_not(@presented_resources.map(&:id)), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(@resource_search.category_ids_no_blanks).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
    render 'resources/index'
  end
end
