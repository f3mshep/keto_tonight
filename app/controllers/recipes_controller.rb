class RecipesController < ApplicationController
    include RecipesHelper
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
        @recipe.assign_attributes(recipe_params)
        wrapper = EdamamWrapper.new
        food_hash = wrapper.line_ingredient_parser(@recipe.ingredient_list)
        add_nutrition(food_hash, @recipe)
        if @recipe.save
            add_ingredients(food_hash, @recipe)
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
       params.require(:recipe).permit(:title, :description, :like, :user_id, :serving_size, :ingredient_list, :cook_time, :prep_time, :servings)
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end
