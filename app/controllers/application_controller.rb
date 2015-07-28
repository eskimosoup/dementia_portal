class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :global_site_settings, :set_menus

  def index
    @presented_categories = BaseCollectionPresenter.new(collection: Category.home_page, view_template: view_context, presenter: CategoryPresenter)
    @resource_search = ResourceSearch.new
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings

  def set_menus
    @header_menu = Optimadmin::Menu.new(name: "header")
    @header_aside_menu = Optimadmin::Menu.new(name: "header_aside")
    @footer_menu = Optimadmin::Menu.new(name: "footer")
  end
end
