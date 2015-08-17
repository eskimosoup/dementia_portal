class ApplicationController < ActionController::Base

  before_action :set_seo_variables

  def sitemap
    @seo_entries = SeoEntry.where(in_sitemap: true).order(:nominal_url)

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def set_seo_variables
    seo_entry = SeoEntry.find_by_nominal_url(request.path)
    return unless seo_entry
    @title = seo_entry.title
    @meta_description = seo_entry.meta_description
    @meta_tags = seo_entry.title
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :global_site_settings, :load_objects

  include TwitterHelper

  def index
    @presented_target_groups = BaseCollectionPresenter.new(collection: TargetGroup.where(display: true), view_template: view_context, presenter: TargetGroupPresenter)
    @presented_categories = BaseCollectionPresenter.new(collection: Category.home_page.order(position: :asc), view_template: view_context, presenter: CategoryPresenter)
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
