module Optimadmin
  class OrganisationPresenter < Optimadmin::BasePresenter
    presents :organisation

    def name
      organisation.name
    end

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def optimadmin_summary
      h.raw organisation.address
    end
  end
end
