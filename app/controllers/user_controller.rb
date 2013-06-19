class UserController < ApplicationController
	def show
		#try to select user from database by given userID
		user = User.where("uid = ?", params[:uid]).first
		#TODO check if AuthToken has expired
		#wehen cant find user in Database get him from facebook
		if user
			if user.oauth_expires_at < Time.now
				@songs = user.getSongsFromFacebook
				render "home/index"
			else
				flash[:error] = "oAuthExpired"
			end
		else
			flash[:error] = "notAUser"
		end
	end
	def getData
			render :json => current_user.getFriends
	end
end
