class StaticController < ApplicationController

  def home
    if current_user
      redirect_to user_home_path
    end
  end

  def search
  end

end
