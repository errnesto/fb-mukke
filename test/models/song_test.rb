require "test_helper"

describe Song do

	it "can tell when a youtube link is a song" do
		songHash = Song.fetch_atributes('http://www.youtube.com/watch?v=9PnOG67flRA')
		songHash.wont_be_nil
	end
	it "can tell that a soundcloud link is a song" do
		songHash = Song.fetch_atributes('https://soundcloud.com/fineripp/fineripps-downbeat-menu')
		songHash.wont_be_nil
	end
	it "can tell when a youtube link is not a song" do
		songHash = Song.fetch_atributes('http://www.youtube.com/watch?v=0fKBhvDjuy0')
		songHash.must_be_nil
	end

	it "can tell that a any other link is not a song" do
		songHash = Song.fetch_atributes('http://www.google.com')
		songHash.must_be_nil
	end

	it "can find out the source of its soundcloud url" do
		songHash = Song.fetch_atributes('https://soundcloud.com/fineripp/fineripps-downbeat-menu')
		songHash['source'].must_equal 'soundcloud'
	end

	it "can find out the source of its youtube url" do
		songHash = Song.fetch_atributes('http://www.youtube.com/watch?v=9PnOG67flRA')
		songHash['source'].must_equal 'youtube'
	end

	describe "metadata of the song" do

		it "can find out its name from its youtube url" do
			songHash = Song.fetch_atributes('http://www.youtube.com/watch?v=9PnOG67flRA')
			songHash['name'].must_equal 'Metronomy - The Bay'
		end

		it "can find out its name from its soundcloud url" do
			songHash = Song.fetch_atributes('https://soundcloud.com/fineripp/fineripps-downbeat-menu')
			songHash['name'].must_equal "FineRipp's Downbeat Menu"
		end

		it "can get an image from its youtube url" do
			songHash = Song.fetch_atributes('http://www.youtube.com/watch?v=9PnOG67flRA')
			songHash['image'].must_include 'ytimg.com/vi/9PnOG67flRA/mqdefault.jpg'
		end

		it "can get an image from its soundcloud url" do
			songHash = Song.fetch_atributes('https://soundcloud.com/fineripp/fineripps-downbeat-menu')
			songHash['image'].must_include 'sndcdn.com/artworks-000046589747-3ubydb-t300x300.jpg'
		end

	end

end
