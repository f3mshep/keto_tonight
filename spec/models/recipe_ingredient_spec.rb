require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do

    before(:each) do
      @recipe = Recipe.create
      @ingredient = Ingredient.create
      @recipe_ingredient = @recipe.recipe_ingredients.create(ingredient: @ingredient)
    end

  describe 'recipe_ingredients' do

    it 'belongs to a recipe' do
      expect(@recipe_ingredient.recipe).to eq(@recipe)
    end

    it 'belongs to an ingredient' do
      expect(@recipe_ingredient.ingredient).to eq(@ingredient)
    end

  end

  describe '#amount' do
    it 'has an amount that defaults to 1' do
      expect(@recipe_ingredient.amount).to eq(1)
    end
  end

end
