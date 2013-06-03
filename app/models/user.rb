class User < ActiveRecord::Base
	
	#write user to database or update existing user
	def self.from_omniauth(auth)
		where(auth.slice(:uid)).first_or_initialize.tap do |user|
			user.uid = auth.uid
			user.first_name = auth.info.first_name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end

	def getSongsFromFacebook
		#me = FbGraph::User.me(self.oauth_token)
		user = FbGraph::User.fetch(self.uid, :access_token => self.oauth_token)
		all_links = user.links(:fields => 'link')
		song_links = []
		all_links.each do |url|
			if (url.link.include? "youtube")
				song_links.push(url.link)
			end
		end
		song_links
	end
end
