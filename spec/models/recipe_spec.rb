require 'rails_helper'

RSpec.describe Recipe, type: :model do
before(:each) do
  @user = User.create(email: 'testymctestface@gmail.com', password: 'securepassword')
  @recipe = Recipe.create(user: @user, likes: 1)
  @ingredient = Ingredient.create(fiber: 3, carbs: 10, protein: 17, fat: 20 )
  @category = Category.create
  @recipe_category = @recipe.recipe_categories.create(category: @category)
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
    it 'can calculate nutritional info' do
      expect(@recipe.nutrition_info).to include("3g fiber")
    end
  end

  describe '#change_likes' do
    it 'can change the likes' do
      expect(@recipe.change_rating(1)).to eq(2)
    end
  end


end
