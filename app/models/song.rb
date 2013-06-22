class Song < ActiveRecord::Base
	belongs_to :list
	belongs_to :user

	require 'open-uri'

	#after the constructor is called do:
	def self.fetch_atributes(url)
		song = Hash.new
		song['url'] = url
	  	if(url.include? 'youtube')
	  		song['source'] = 'youtube'
	  		#extract the video ID from the youtube url
	  		song['identifier'] = url.match(/[\\?\\&]v=([^\\?\\&]+)/)[1]

	  		#get the medata of the video from the youtube api
	  		json = open('https://gdata.youtube.com/feeds/api/videos/'+song['identifier']+'?v=2&alt=json')
	  		metadata = JSON.parse(json.read)['entry']['media$group']

	  		if(metadata['media$category'][0]['$t'] == "Music")
	  			#tagged as song: store metaddata from youtube
	  			song['name'] = metadata['media$title']['$t']
	  			song['image'] = metadata['media$thumbnail'][1]['url']
	  			#TODO: look for media$restriction and do something about it

	  			song
	  		else
	  			#not a song just return nil
	  			nil
	  		end
	  	elsif(url.include? 'soundcloud')
	  		song['source'] = 'soundcloud'
	  		#get metadata from soundcloud api
	  		json = open('https://api.soundcloud.com/resolve.json?url='+self.url+'&client_id=978f352c112cb02aa31166a4824dd0da')
	  		metadata = JSON.parse(json.read)
	  		song['identifier'] = metadata['stream_url']
	  		song['name'] = metadata['title']
	  		song['image'] = metadata['artwork_url']
	  		#replace small artwork image url with bigger one
	  		song['image'].sub!('large','t300x300')

	  		song
	  	else
	  		#not a song
	  		nil
	  	end
	end

end
