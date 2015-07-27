module Optimadmin
  class OrganisationsController < Optimadmin::ApplicationController
    before_action :set_organisation, only: [:show, :edit, :update, :destroy]

    def index
      @organisations = Optimadmin::BaseCollectionPresenter.new(collection: Organisation.name_search(params[:search]).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::OrganisationPresenter)
    end

    def show
    end

    def new
      @organisation = Organisation.new
    end

    def edit
    end

    def create
      @organisation = Organisation.new(organisation_params)
      if @organisation.save
        redirect_to organisations_url, notice: 'Organisation was successfully created.'
      else
        render :new
      end
    end

    def update
      if @organisation.update(organisation_params)
        redirect_to organisations_url, notice: 'Organisation was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @organisation.destroy
      redirect_to organisations_url, notice: 'Organisation was successfully destroyed.'
    end

  private


    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    def organisation_params
      params.require(:organisation).permit(:name, :address, :postcode, :organisation_type, :phone, :email, :website)
    end
  end
end
