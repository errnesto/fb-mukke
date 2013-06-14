class UserController < ApplicationController
	def getData
		render :json => @user
	end
end
