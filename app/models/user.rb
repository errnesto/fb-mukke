class User < ActiveRecord::Base
	has_many :songs
	
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
		user = @fbUser||callFbApi
		all_links = user.links(:fields => 'link')
		songs = []
		all_links.each do |url|
			#when url is a song add it to output
			song = Song.new(:url => url.link)
			if (song.isSong?)
				song.set_atributes
				songs.push(song)
			end
		end
		songs
	end

	def getFriends
		user = @fbUser||callFbApi
		user.friends(:fields => 'identifier,name')
	end

	def callFbApi
		@fbUser = FbGraph::User.fetch(self.uid, :access_token => self.oauth_token)
	end
end
