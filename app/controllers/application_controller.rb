class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def allow_iframe
	response.headers["X-Frame-Options"] = "ALLOW-FROM https://apps.facebook.com"
  end
end
