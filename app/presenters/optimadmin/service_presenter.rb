module Optimadmin
  class ServicePresenter < Optimadmin::BasePresenter
    presents :service

    def name
      service.name
    end
  end
end