module Optimadmin
  class OrganisationPresenter < Optimadmin::BasePresenter
    presents :organisation

    def name
      organisation.name
    end
  end
end