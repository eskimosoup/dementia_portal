class PagesController < ApplicationController
  def show
    @page = PagePresenter.new(object: Page.friendly.where(display: true).find(params[:id]), view_template: view_context)
    redirect_to @page, status: :moved_permanently if request.path != page_path(@page)
  end
end
