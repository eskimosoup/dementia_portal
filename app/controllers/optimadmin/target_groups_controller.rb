module Optimadmin
  class TargetGroupsController < Optimadmin::ApplicationController
    before_action :set_target_group, only: [:show, :edit, :update, :destroy]

    def index
      @target_groups = Optimadmin::BaseCollectionPresenter.new(collection: TargetGroup.where('title LIKE ?', "#{params[:search]}").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::TargetGroupPresenter)
    end

    def show
    end

    def new
      @target_group = TargetGroup.new
    end

    def edit
    end

    def create
      @target_group = TargetGroup.new(target_group_params)
      if @target_group.save
        redirect_to target_groups_url, notice: 'Target group was successfully created.'
      else
        render :new
      end
    end

    def update
      if @target_group.update(target_group_params)
        redirect_to target_groups_url, notice: 'Target group was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @target_group.destroy
      redirect_to target_groups_url, notice: 'Target group was successfully destroyed.'
    end

  private


    def set_target_group
      @target_group = TargetGroup.find(params[:id])
    end

    def target_group_params
      params.require(:target_group).permit(:name, :display)
    end
  end
end
