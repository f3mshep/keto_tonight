require 'rails_helper'

RSpec.describe Pantry, type: :model do
  before(:each) do

    @ingredient = Ingredient.create
    @pantry = Pantry.create
    @pantry_ingredient = @pantry.pantry_ingredient.create(ingredient: @ingredient)
    @user = User.create(pantry:@pantry)

  end
  describe 'Pantry' do

    it 'belongs to a user' do
      expect(@pantry.user).to eq(@user)
    end

    it 'has many ingredients through pantry_ingredients' do
      expect(@pantry.ingredients).to include(@ingredient)
    end

  end

end
