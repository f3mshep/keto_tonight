require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do
  describe 'recipe_categories' do
    before(:each) do
      @recipe = Recipe.create
      @category = Category.create
      @recipe_category = @recipe.recipe_categories.create(category: @category)
    end

    it 'belongs to a recipe' do
      expect(@recipe_category.recipe).to eq(@recipe)
    end

    it 'belongs to a category' do
      expect(@recipe_category.category).to eq(@category)
    end
  end
end
