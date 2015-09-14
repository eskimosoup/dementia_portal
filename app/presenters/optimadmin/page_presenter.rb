module Optimadmin
  class PagePresenter < Optimadmin::BasePresenter
    presents :page

    def id
      page.id
    end

    def title
      page.title
    end

    def content
      h.raw page.content
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      content
    end
  end
end
