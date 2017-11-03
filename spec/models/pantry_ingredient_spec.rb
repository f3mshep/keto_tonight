require 'rails_helper'

RSpec.describe PantryIngredient, type: :model do
  before(:each) do
    @pantry = Pantry.create
    @ingredient = Ingredient.create
    @pantry_ingredient = PantryIngredient.create(pantry: @pantry, ingredient: @ingredient)
  end
  describe 'Pantry Ingredients' do
    it 'belongs to a pantry' do
      expect(@pantry_ingredient.pantry).to eq(@pantry)
    end

    it 'belongs to a ingredient' do
      expect(@pantry_ingredient.ingredient).to eq(@ingredient)
    end
  end

end
