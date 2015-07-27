module Optimadmin
  class ResourcePresenter < Optimadmin::BasePresenter
    presents :resource

    def name
      resource.name
    end
  end
end