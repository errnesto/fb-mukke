class UserController < ApplicationController
	after_filter :allow_iframe

	def show
		#if visitor is not logged in open facebook login dialog
		if(!current_user)			
			redirect_to('/auth/facebook/')
			return
		end

		#try to select user from database by given userID
		user = User.where("uid = ?", params[:uid]).first
		#TODO check if AuthToken has expired
		#wehen cant find user in Database get him from facebook
		if user
			if user.oauth_expires_at > Time.now
				#user exist in database and oauth_token is valid
				@songs = user.getSongsFromFacebook
			else
				#user exist in database but oauth_token is expired
				flash.now[:error] = "oAuthExpired"
				#get songs with oauth_token from current_user
				@songs = user.getSongsFromFacebook(current_user.oauth_token)
			end
		else
			#user does not exist in database and therefore has no oauth_token
			flash.now[:error] = "notAuser"
			#replace underscores with whitespace
			name = params[:name].gsub(/_/,' ')
			#create a tempprayry user
			user = User.new(:uid => params[:uid],:name => name)
			@songs = user.getSongsFromFacebook(current_user.oauth_token)
		end
		@user = user;
		render "home/index"
	end
	def getData
		#always get the friends of the current user
		render :json => current_user.getFriends
	end
end
