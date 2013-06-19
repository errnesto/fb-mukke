class User < ActiveRecord::Base
	has_many :songs
	
	#write user to database or update existing user
	def self.from_omniauth(auth)
		where(auth.slice(:uid)).first_or_initialize.tap do |user|
			user.uid = auth.uid
			user.name = auth.info.name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end

	#if no oauth_token is provided use the stored one
	#this makes it possible to get songs with a token from an other user this should only be done when no token is stored
	def getSongsFromFacebook(oauth_token = self.oauth_token)
		#if we already have the user data use it elese get them from facebook
		user = @fbUser||callFbApi(oauth_token)
		all_links = user.links(:fields => 'link', :limit => 600)
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
		#if we already have the user data use it elese get them from facebook
		user = @fbUser||callFbApi
		friendsObject = user.friends(:fields => 'id,name,picture')
		friends = []
		friendsObject.each do |friend|
			friends.push friend.raw_attributes
		end
		#add the user itself to the list of its friends
		friends.push( {'id' => self.uid, 'name' => self.name} )
		friends
	end

	def callFbApi(oauth_token = self.oauth_token)
		@fbUser = FbGraph::User.fetch(self.uid, :access_token => oauth_token)
	end
end
