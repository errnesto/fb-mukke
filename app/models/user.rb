class User < ActiveRecord::Base
	has_many :songs
	
	#write user to database or update existing user
	def self.from_omniauth(auth)
		where(auth.slice(:uid)).first_or_initialize.tap do |user|
			user.uid = auth.uid
			user.name = auth.info.name
			user.picture = auth.info.image
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
		all_links = user.links(:fields => 'link', :limit => 100)
		songs = []
		threads = []
		all_links.each_with_index do |url,i|
			#song makes calls to youtube and sounfclod apis use threads to make them asyconus
			threads << Thread.new do
				#when try to fetch song atributes from the link if not possible it will be nil
				begin
					songs[i] = Song.fetch_atributes(url.link)
				rescue
					#cant create valid song: ignore it
				end
			end
		end
		#wait for each thread to finish before continue
		threads.each do |thr|
			thr.join
		end
		#remove all nil elements from the song array
		songs.compact!
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
		#add the user itself to the list of its friends #in the same format as we get it from facebook
		friends.push( {'id' => self.uid, 'name' => self.name, 'picture' => {'data' => {'url' => self.picture}} } )
		friends
	end

	def callFbApi(oauth_token = self.oauth_token)
		@fbUser = FbGraph::User.fetch(self.uid, :access_token => oauth_token)
	end
end
