module Optimadmin
  class ArticlePresenter < Optimadmin::BasePresenter
    presents :article

    def title
      article.title
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      h.raw article.summary
    end
  end
end
