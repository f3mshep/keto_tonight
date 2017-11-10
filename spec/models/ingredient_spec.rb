require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:each) do
    @user = User.create(email: 'testymctestface@gmail.com', password: 'securepassword')
    @ingredient = Ingredient.create(name: 'zuchini', serving_size: '1 cup', carbs: 15, fiber: 13  )
    @recipe = Recipe.create(title: 'Zoodle Pasta', user: @user)
    @recipe_ingredient = RecipeIngredient.create(recipe: @recipe, ingredient: @ingredient)
  end

  describe 'ingredients' do
    it 'has many recipe ingredients' do
      expect(@ingredient.recipe_ingredients).to include(@recipe_ingredient)
    end

    it 'has many recipes through ingredient_recipes' do
      expect(@ingredient.recipes).to include(@recipe)
    end

  end



end
