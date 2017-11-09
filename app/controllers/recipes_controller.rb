class RecipesController < ApplicationController

    before_action :recipe_setter, only: [:show, :edit, :update]

    def index
        if params[:user_id]
            @recipes = User.find(params[:user_id]).recipes
        else
            @recipes = Recipe.all
        end
    end

    def show

    end

    def new
        @recipe = Recipe.new(user: current_user)
    end

    def create
        @recipe = Recipe.new(user: current_user)
        @recipe.categories.build
        @recipe.assign_attributes(recipe_params)

        if @recipe.save
            @recipe.save_food
            redirect_to user_recipe_path(@recipe.user, @recipe)
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def delete
    end

    private

    def recipe_params
       params.require(:recipe).permit(:title, :description, :serving_size,
       :ingredient_list, :cook_time, :prep_time, :servings,
       :category_attributes, :category_ids => [])
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end
