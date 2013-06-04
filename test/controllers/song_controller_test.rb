require 'test_helper'

describe SongController do

	it "should add a song to a list and save it to the database" do
		get :star, :url => 'http://www.youtube.com/watch?v=9PnOG67flRA' , :list_id => 1
		Song.first.url.must_equal 'http://www.youtube.com/watch?v=9PnOG67flRA'
		List.find(1).songs.first.url.must_equal 'http://www.youtube.com/watch?v=9PnOG67flRA'
	end

	it "delete a song from the list and the database" do
		song = Song.new
		song.save
		get :unstar ,:id => song.id
		Song.find(song.id).must_be_nil
	end

	it "should always redirect to root" do
		get :star
		assert_redirected_to('/')
		get :unstar
		assert_redirected_to('/')
	end
end