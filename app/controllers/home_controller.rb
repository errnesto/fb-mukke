class HomeController < ApplicationController
	def index
		#if user is not logged in open facebook login dialog
		if(!current_user)			
			redirect_to('/auth/facebook/')
		end
	end

end
