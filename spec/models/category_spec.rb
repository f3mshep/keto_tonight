require 'rails_helper'

RSpec.describe Category, :type => :model do
  before(:each) do
    @user = User.create(email: 'testymctestface@gmail.com', password: 'securepassword')
    @category = Category.create(name: 'Dinner')
    @recipe = Recipe.create(title: 'Pasta', user: @user)
    @recipe_category = @recipe.recipe_categories.create(category: @category)
  end

  describe 'categories' do
    it 'has many recipe_categories built through instance method' do

      expect(@category.recipe_categories).to include(@recipe_category)
    end

    it 'has many items through line_items' do
      expect(@category.recipes).to include(@recipe)
    end
  end

end