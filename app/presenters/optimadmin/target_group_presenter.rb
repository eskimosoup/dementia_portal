module Optimadmin
  class TargetGroupPresenter < Optimadmin::BasePresenter
    presents :target_group

    def title
      target_group.name
    end
  end
end
