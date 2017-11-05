require 'rails_helper'

RSpec.describe Pantry, type: :model do
  before(:each) do

    @user = User.create(email: 'testymctestface@gmail.com', password: 'securepassword', pantry: @pantry)
    @ingredient = Ingredient.create
    @pantry = Pantry.create(user: @user)
    @pantry_ingredient = @pantry.pantry_ingredients.create(ingredient: @ingredient)


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
