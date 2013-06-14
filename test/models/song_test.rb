require "test_helper"

describe Song do
	before do
		@song = Song.new
	end

	it "can tell when a youtube link is a song" do
		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.isSong?.must_equal true
	end
	it "can tell that a soundcloud link is a song" do
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.isSong?.must_equal true
	end
	it "can tell when a youtube link is not a song" do
		@song.url ='http://www.youtube.com/watch?v=0fKBhvDjuy0'
		@song.isSong?.must_equal false
	end

	it "can find out the source of its soundcloud url" do
		@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
		@song.isFrom.must_equal 'soundcloud'
	end

	it "can find out the source of its youtube url" do
		@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
		@song.isFrom.must_equal 'youtube'
	end

	describe "metadata of the song" do

		it "can find out its name from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			if (@song.isSong?)
				@song.set_atributes
			end
			@song.name.must_equal 'Metronomy - The Bay'
		end

		it "can find out its name from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			if (@song.isSong?)
				@song.set_atributes
			end
			@song.name.must_equal "FineRipp's Downbeat Menu"
		end

		it "can get an image from its youtube url" do
			@song.url = 'http://www.youtube.com/watch?v=9PnOG67flRA'
			if (@song.isSong?)
				@song.set_atributes
			end
			@song.image.must_equal 'https://i.ytimg.com/vi/9PnOG67flRA/mqdefault.jpg'
		end

		it "can get an image from its soundcloud url" do
			@song.url = 'https://soundcloud.com/fineripp/fineripps-downbeat-menu'
			if (@song.isSong?)
				@song.set_atributes
			end
			@song.image.must_equal 'http://i1.sndcdn.com/artworks-000046589747-3ubydb-t300x300.jpg?0c5f27c'
		end

	end

end