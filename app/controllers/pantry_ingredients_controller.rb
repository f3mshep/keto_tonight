class PantryIngredientsController < ApplicationController

def destroy
  pantry_ingredient = PantryIngredient.find(params[:id])
  pantry = pantry_ingredient.pantry
  pantry_ingredient.destroy
  redirect_to user_pantry_path(pantry)
end

end
