class SessionsController < ApplicationController
  def create
  	#save user information
    user = User.from_omniauth(request.env["omniauth.auth"])
    #create session with current user
    session[:user_id] = user.id
    redirect_to '/'
  end

  def destroy
  	#destroy session
    session[:user_id] = nil
    redirect_to '/'
  end
end