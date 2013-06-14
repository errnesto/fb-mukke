class Song < ActiveRecord::Base
	belongs_to :list
	belongs_to :user

	require 'open-uri'

	#after the constructor is called do:
	def set_atributes
	  	if( (self.source||= isFrom) == 'youtube')
	  		#store metaddata from youtube
	  		self.name = @metadata['media$title']['$t']
	  		self.image = @metadata['media$thumbnail'][1]['url']
	  	elsif( (self.source||= isFrom) == 'soundcloud')
	  		#get metadata from soundcloud api
	  		json = open('http://api.soundcloud.com/resolve.json?url='+self.url+'&client_id=978f352c112cb02aa31166a4824dd0da')
	  		@metadata = JSON.parse(json.read)
	  		self.identifier = @metadata['stream_url']
	  		self.name = @metadata['title']
	  		self.image = @metadata['artwork_url']
	  		#replace small artwork image url with bigger one
	  		self.image.sub!('large','t300x300')
	  	end
	end

	def isSong?
		if( (self.source||= isFrom) == 'soundcloud')
			true
		elsif( (self.source||= isFrom) == 'youtube')
			#extract the video ID from the youtube url
			self.identifier = self.url.match(/[\\?\\&]v=([^\\?\\&]+)/)[1]
			#get the medata of the video from the youtube api
			json = open('https://gdata.youtube.com/feeds/api/videos/'+self.identifier+'?v=2&alt=json')
			@metadata = JSON.parse(json.read)['entry']['media$group']
			if(@metadata['media$category'][0]['$t'] == "Music")
				true
			else
				false
			end
		else
			false
		end
	end

	def isFrom
		if(self.url.include? 'youtube')
			'youtube'
		elsif(self.url.include? 'soundcloud')
			'soundcloud'
		end
	end
end
