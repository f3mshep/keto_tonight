class PantriesController < ApplicationController

  def show
    pantry_setter
  end

  def edit
    pantry_setter
    @ingredient = Ingredient.new
    @pantry_ingredient = PantryIngredient.new(pantry: @pantry, ingredient: @ingredient)
  end

  def update

  end

  private

  def pantry_setter
     @user = User.find(params[:user_id])
     @pantry = @user.pantry
     @pantry = Pantry.create(user: @user) if @pantry.nil?
  end

  def pantry_params
  end

end
