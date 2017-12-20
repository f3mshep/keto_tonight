class UsersController < ApplicationController
  before_action :require_login

  def home
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

end
