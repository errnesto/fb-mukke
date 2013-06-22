class HomeController < ApplicationController
	after_filter :allow_iframe

	def index
		#if user is not logged in open facebook login dialog
		if(!current_user)			
			redirect_to('/auth/facebook/')
		else
			@user = current_user
			@songs = current_user.getSongsFromFacebook
		end
	end
	
end
