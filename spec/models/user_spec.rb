require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(email: 'testymctestface@gmail.com', password: 'securepassword')
    @comment = @user.comments.create
    @recipe = @user.recipes.create(user: @user)
  end
  describe 'user' do
    it "has many comments" do

      expect(@user.comments).to include(@comment)
    end

    it "has one pantry" do
      expect(@user.pantry).to eq(@pantry)
    end

    it "has many recipes" do
      expect(@user.recipes).to include(@recipe)
    end
  end

end
