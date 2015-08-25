module Optimadmin
  class SubCategoriesController < Optimadmin::ApplicationController
    before_action :set_sub_category, only: [:show, :edit, :update, :destroy]

    def index
      @sub_categories = Optimadmin::BaseCollectionPresenter.new(collection: SubCategory.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::SubCategoryPresenter)
    end

    def show
    end

    def new
      @sub_category = SubCategory.new
    end

    def edit
    end

    def create
      @sub_category = SubCategory.new(sub_category_params)
      if @sub_category.save
        redirect_to sub_categories_url, notice: 'SubCategory was successfully created.'
      else
        render :new
      end
    end

    def update
      if @sub_category.update(sub_category_params)
        redirect_to sub_categories_url, notice: 'SubCategory was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @sub_category.destroy
      redirect_to sub_categories_url, notice: 'SubCategory was successfully destroyed.'
    end

  private


    def set_sub_category
      @sub_category = SubCategory.find(params[:id])
    end

    def sub_category_params
      params.require(:sub_category).permit(:name, :display, :category_id)
    end
  end
end
