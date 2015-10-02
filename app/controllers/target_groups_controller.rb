class TargetGroupsController < ApplicationController

  before_action :set_target_group

  def show
    redirect_to resources_path(resource_search: { target_group_ids: [@target_group.id] })
  end

  def set_target_group
    @target_group = TargetGroup.friendly.find(params[:id])
  end
end
