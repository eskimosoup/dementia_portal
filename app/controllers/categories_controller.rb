class CategoriesController < ApplicationController
  before_action :set_category

  def show
    @resource_search = ResourceSearch.new(params.fetch(:resource_search, {}).merge(sub_category_ids: @category.sub_category_ids).delete_if{|k,v| v.blank? })
    @presented_resources = BaseCollectionPresenter.new(collection: @presented_category.resources.displayed.uniq, view_template: view_context, presenter: ResourcePresenter)
    @presented_related_resources = BaseCollectionPresenter.new(collection: Resource.displayed.sub_categories(@presented_category.sub_category_ids)
                                                  .id_not(@presented_resources.map(&:id)), view_template: view_context, presenter: ResourcePresenter)
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active.categories(@presented_category.id).limit(3),
                                                      view_template: view_context, presenter: ArticlePresenter)
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
    @presented_category = CategoryPresenter.new(object: @category, view_template: view_context)
    if request.path != category_path(@presented_category)
      redirect_to @presented_category
    end
  end
end
