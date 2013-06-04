require "test_helper"

describe Song do
	before do
		@song = Song.new
	end

	it "can tell when a youtube link is a song" do
		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.set_atributes
		@song.isSong?.must_equal true
	end
	it "can tell that a soundcloud link is a song" do
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.set_atributes
		@song.isSong?.must_equal true
	end
	it "can tell when a youtube link is not a song" do
		@song.url ='http://www.youtube.com/watch?v=0fKBhvDjuy0'
		@song.set_atributes
		@song.isSong?.must_equal false
	end

	it "can find out the source of its soundcloud url" do
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.set_atributes
		@song.isFrom.must_equal 'soundcloud'
	end

	it "can find out the source of its youtube url" do
		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.set_atributes
		@song.isFrom.must_equal 'youtube'
	end

	describe "metadata of the song" do

		it "can find out its name from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			@song.set_atributes
			@song.name.must_equal 'Metronomy - The Bay'
		end

		it "can find out its name from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			@song.set_atributes
			@song.name.must_equal "FineRipp's Downbeat Menu by FineRipp"
		end

		it "can get an image from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			@song.set_atributes
			@song.image.must_equal 'https://i.ytimg.com/vi/9PnOG67flRA/mqdefault.jpg'
		end

		it "can get an image from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			@song.set_atributes
			@song.image.must_equal "http://i1.sndcdn.com/artworks-000046589747-3ubydb-t500x500.jpg?86be403"
		end

	end

end