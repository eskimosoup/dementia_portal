module ApplicationHelper

  def on_category_page?(category)
    request.path == category_path(category)
  end
end
