require "test_helper"

describe Song do
	before do
		@song = Song.new
	end

	it "can tell weather a link is a song or not" do
		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.isSong?.must_equal true
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.isSong?.must_equal true

		@song.url = 'http://www.youtube.com/watch?v=0fKBhvDjuy0'
		@song.isSong?.must_equal false
	end

	it "can find out the source of its url" do
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.isFrom.must_equal 'soundcloud'

		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.isFrom.must_equal 'youtube'
	end

	describe "metadata of the song" do

		it "can find out its name from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			@song.name.must_equal 'Metronomy - The Bay'
		end

		it "can find out its name from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			@song.name.must_equal "FineRipp's Downbeat Menu"
		end

		it "can get an image from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			@song.image.must_equal 'http://img.youtube.com/vi/9PnOG67flRA/mqdefault.jpg'
		end

		it "can get an image from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			@song.image.must_equal "add img url here"
		end

	end

end