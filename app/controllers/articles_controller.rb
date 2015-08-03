class ArticlesController < ApplicationController
  def index
    @presented_articles = BaseCollectionPresenter.new(collection: Article.active, view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    article = Article.friendly.find(params[:id])
    @presented_article = ArticlePresenter.new(object: article, view_template: view_context)
  end
end
