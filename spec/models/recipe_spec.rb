require 'rails_helper'

RSpec.describe Recipe, type: :model do
before(:each) do
  @user = User.create
  @recipe = Recipe.create(user: @user)
  @ingredient = Ingredient.create
  @category = Category.create
  @recipe_category = @recipe.recipe_category.create(category: @category)
  @recipe_ingredient = @recipe.recipe_ingredients.create(ingredient: @ingredient)
end
  describe 'recipe' do
    it 'has many categories through recipe_categories' do
      expect(@recipe.categories).to include(@category)
    end

    it 'has many ingredients through recipe_ingredients' do
      expect(@recipe.ingredients).to include(@ingredient)
    end

    it 'belongs to a user' do
      expect(@recipe.user).to eq(@user)
    end
  end

  describe '#nutrition_info' do
  end

  describe '#change_rating' do
  end


end
