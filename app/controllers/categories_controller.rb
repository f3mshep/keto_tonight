class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @recipes = RecipeCategory.recipes_by_category(params[:id])
    render :'recipes/index'
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy
    redirect_to categories_path
  end

end
