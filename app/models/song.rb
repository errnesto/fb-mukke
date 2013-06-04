class Song < ActiveRecord::Base
	belongs_to :list
	belongs_to :user

	require 'open-uri'

	#after the constructor is called do:
	def set_atributes
	  if(isSong?)
	  	if( (self.source||= isFrom) == 'youtube')
	  		self.name = @metadata['media$title']['$t']
	  		self.image = @metadata['media$thumbnail'][1]['url']
	  	elsif( (self.source||= isFrom) == 'soundcloud')
	  		json = open('http://soundcloud.com/oembed?format=json&url='+self.url)
	  		@metadata = JSON.parse(json.read)
	  		self.name = @metadata['title']
	  		self.image = @metadata['thumbnail_url']
	  	end
	  end
	end

	def isSong?
		if( (self.source||= isFrom) == 'soundcloud')
			true
		elsif( (self.source||= isFrom) == 'youtube')
			#extract the video ID from the youtube url
			videoID = self.url.match(/[\\?\\&]v=([^\\?\\&]+)/)[1]
			#get the medata of the video from the youtube api
			json = open('https://gdata.youtube.com/feeds/api/videos/'+videoID+'?v=2&alt=json')
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
