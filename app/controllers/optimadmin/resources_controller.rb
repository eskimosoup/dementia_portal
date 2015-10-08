module Optimadmin
  class ResourcesController < Optimadmin::ApplicationController
    before_action :set_resource, only: [:show, :edit, :update, :destroy]

    def index
      @resources = Optimadmin::BaseCollectionPresenter.new(collection: Resource.name_search(params[:search]).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::ResourcePresenter)
    end

    def show
    end

    def new
      @resource = Resource.new
    end

    def edit
    end

    def create
      @resource = Resource.new(resource_params)
      if @resource.save
        @resource.sub_categories.each(&:update_active_resources_count)
        @resource.target_groups.each(&:update_active_resources_count)
        redirect_to resources_url, notice: 'Resource was successfully created.'
      else
        render :new
      end
    end

    def update
      if @resource.update(resource_params)
        @resource.sub_categories.each(&:update_active_resources_count)
        @resource.target_groups.each(&:update_active_resources_count)
        redirect_to resources_url, notice: 'Resource was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @resource.destroy
      @resource.sub_categories.each(&:update_active_resources_count)
      @resource.target_groups.each(&:update_active_resources_count)
      redirect_to resources_url, notice: 'Resource was successfully destroyed.'
    end

  private


    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(:name, :summary, :description, :url, :youtube_embed_code, :organisation_id, :date,
                                       :time, :venue, :display, :address, :postcode, sub_category_ids: [], target_group_ids: [])
    end
  end
end
