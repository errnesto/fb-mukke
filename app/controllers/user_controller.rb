class UserController < ApplicationController
	def getData
			render :json => current_user.getFriends
	end
end
