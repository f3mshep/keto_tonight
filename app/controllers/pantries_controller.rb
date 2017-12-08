class PantriesController < ApplicationController

  before_action :require_login
  before_action :pantry_setter, only: [:show, :edit, :update]

  def show
  end

  def edit
    @pantry.ingredients.build
  end

  def update
    if  @pantry.update(pantry_params)
      redirect_to user_pantry_path(@user)
    else
      @pantry.ingredients.build
      render :edit
    end
  end

  def delete
  end

  private

  def pantry_setter
     @user = current_user
     @pantry = @user.pantry
     @pantry = Pantry.create(user: @user) if @pantry.nil?
  end

  def pantry_params
    params.require(:pantry).permit(ingredients_attributes: [
      :name
    ])
  end

end
