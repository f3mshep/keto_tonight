class PantriesController < ApplicationController

  def show
    pantry_setter
  end

  def edit

  end

  def update

  end

  private

  def pantry_setter
     @pantry = User.find(params[:user_id]).pantry
  end

  def pantry_params
  end

end
