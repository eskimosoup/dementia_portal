class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :global_site_settings, :load_objects

  include TwitterHelper

  def index
    @target_groups = TargetGroup.where(display: true)
    @presented_categories = BaseCollectionPresenter.new(collection: Category.home_page, view_template: view_context, presenter: CategoryPresenter)
    @resource_search = ResourceSearch.new
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings

  def load_objects
    @header_menu = Optimadmin::Menu.new(name: "header")
    @header_aside_menu = Optimadmin::Menu.new(name: "header_aside")
    @footer_menu = Optimadmin::Menu.new(name: "footer")

    latest_article = Article.active.first
    @presented_article = ArticlePresenter.new(object: latest_article, view_template: view_context)
  end
end
