class UserController < ApplicationController
	def show
		#try to select user from database by given userID
		user = User.where("uid = ?", params[:uid]).first
		#TODO check if AuthToken has expired
		#wehen cant find user in Database get him from facebook
		if user
			if user.oauth_expires_at > Time.now
				#user exist in database and oauth_token is valid
				@songs = user.getSongsFromFacebook
				render "home/index"
			else
				#user exist in database but oauth_token is expired
				flash[:error] = "oAuthExpired"
				#get songs with oauth_token from current_user
				@songs = user.getSongsFromFacebook(current_user.oauth_token)
			end
		else
			#user does not exist in database and therefore has no oauth_token
			flash[:error] = "notAuser"
			user = User.new(:uid => params[:uid])
			@songs = user.getSongsFromFacebook(current_user.oauth_token)
		end
		render "home/index"
	end
	def getData
		#always get the friends of the current user
		render :json => current_user.getFriends
	end
end
