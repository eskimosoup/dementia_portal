module Optimadmin
  class ResourcePresenter < Optimadmin::BasePresenter
    presents :resource

    def name
      resource.name
    end

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def optimadmin_summary
      h.raw resource.summary
    end
  end
end
