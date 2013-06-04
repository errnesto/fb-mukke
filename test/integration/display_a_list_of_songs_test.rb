require "test_helper"

describe "Display A List Of Songs Test" do

  describe "the list of your own songs" do
    #these test would rely on real facebook responeses
    #we have to look into facebooktest users if they can make these tests more reliable

    it "displays invite friend Button if user has no permission" do
      visit '/user/someoneWioutPermission'
      page.must_have_content('zu fb-mukke einladen')
    end

    it "displays error when no songs where found" do
      visit '/user/someoneWioutSongs'
      page.must_have_content('zu fb-mukke einladen')
    end

    it "renders The youtube and the soundcloud Player" do
      visit '/user/someoneWioutYoutubeAndSoundcloudSongs'
      page.must_have_content('<a href="http://www.youtube')
      page.must_have_content('<a href="http://www.soundcloud')
    end
  end
end