class PantriesController < ApplicationController

  def show
    pantry_setter
  end

  def edit
    #I thought long and hard about how to get pantry ingredients working properly.
    #Technically, what is happening here is that we are editing a User's pantry
    #Therefore, to add a brand new ingredient we needed to use nested params!
    pantry_setter
    @pantry.ingredients.build
  end

  def update
    #one thing this doesn't do is check if the ingredient the user is adding
    #is unique. If they choose to bypass the built in SEARCH FOR ALREADY existing
    #ingredients they must be touchy about exactly what their macronutrients are
    pantry_setter
    if @pantry.update(pantry_params)
      redirect_to user_pantry_path(@user)
    else
      render :edit
    end
  end

  def delete
    #It is a desired behavior to sever the link between the pantry and the
    #ingredient, but not the ingredient itself.

  end

  private

  def pantry_setter
     @user = User.find(params[:user_id])
     @pantry = @user.pantry
     @pantry = Pantry.create(user: @user) if @pantry.nil?
  end

  def pantry_params
    params.require(:pantry).permit(ingredients_attributes: [
      :name,
      :calories,
      :fat,
      :protein,
      :carbs,
      :fiber,
      :serving_size
    ])
  end

end
