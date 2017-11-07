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
        binding.pry
    end
    
    def new
    end
    
    def create
    end

    def edit
    end

    def update
    end

    def delete
    end

    private

    def recipe_params
       raise("#recipe params is a TODO")
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end
