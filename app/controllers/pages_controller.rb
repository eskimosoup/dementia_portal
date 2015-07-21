class PagesController < ApplicationController
  def show
    @page_object = Page.friendly.where(display: true).find(params[:id])
    @page = PagePresenter.new(object: @page_object, view_template: view_context)
    return redirect_to @page_object, status: :moved_permanently if request.path != page_path(@page_object)
  end
end
