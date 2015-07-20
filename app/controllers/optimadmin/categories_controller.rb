module Optimadmin
  class CategoriesController < Optimadmin::ApplicationController
    edit_images_for Category, [[:image, { homepage: ['fill', 300, 300] }]]
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
      @categories = Optimadmin::BaseCollectionPresenter.new(collection: Category.where('title LIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::CategoryPresenter)
    end

    def show
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to categories_url, notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        redirect_to categories_url, notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    end

  private


    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :suggested_url, :image, :image_cache, :remote_image_url, :display, :display_on_home)
    end
  end
end
