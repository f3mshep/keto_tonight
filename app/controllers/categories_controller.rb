class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @recipes =
  end

  def destroy
    @category =
    authorize @category
  end

end
