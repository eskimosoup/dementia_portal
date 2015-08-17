class TargetGroupsController < ApplicationController

  before_action :set_target_group

  def show
    @presented_resources = BaseCollectionPresenter.new(collection: @presented_target_group.resources.displayed,
                                                       view_template: view_context, presenter: ResourcePresenter)
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.id_not(@presented_resources.map(&:id)),
                                                               view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.limit(3), view_template: view_context, presenter: ArticlePresenter)
  end

  def set_target_group
    @presented_target_group = TargetGroupPresenter.new(object: TargetGroup.friendly.find(params[:id]), view_template: view_context)
  end
end
