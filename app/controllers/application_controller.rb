class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  def after_sign_in_path_for(resource)
      request.env['omniauth.origin'] || root_path
  end

  def require_login
    redirect_to new_user_session_path if !current_user
  end

  def has_pantry
    Pantry.create(user: current_user) if current_user.pantry.nil?
  end

end
