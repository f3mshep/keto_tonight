class IngredientsController < ApplicationController

    def show
        @recipes = Recipe.by_ingredients(Ingredient.find(params[:id]).name)
        binding.pry
        render :'recipes/index'
    end

end
