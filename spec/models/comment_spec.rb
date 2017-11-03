require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @recipe = Recipe.create
    @user = User.create
    @comment = Comment.create(recipe: @recipe, user: @user)

  end

  describe 'comments' do
    it 'belongs to a recipe' do
      expect(@comment.user).to eq(@user)
    end

    it 'belongs to a user' do
      expect(@comment.recipe).to eq(@recipe)
    end
  end



end
