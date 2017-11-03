require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:each) do
    @ingredient = Ingredient.create(name: 'zuchini', serving_size: '1 cup', carbs: 15, fiber: 13  )
    @recipe = Recipe.create(title: 'Zoodle Pasta')
    @recipe_ingredient = RecipeIngredient.create(recipe: @recipe, ingredient: @ingredient)
  end

  describe 'ingredients' do
    it 'has many recipe ingredients' do
      expect(@ingredient.recipe_ingredients).to include(@recipe_ingredient)
    end

    it 'has many recipes through ingredient_recipes' do
      expect(@ingredient.recipes).to include(@recipe_ingredient)
    end

  end

  describe '#net_carbs' do
    it 'can calculate net carbs based on the ingredients fiber and total carbs in one serving' do
      expect(@ingredient.net_carbs).to eq(2)
    end

    it 'will not return a negative net carb count' do
      @impossible_food = Ingredient.create(name: 'impossible food', carbs: 20, fiber: 30)
      expect(@impossible_food).to eq(0)
    end
  end


end
