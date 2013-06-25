require "test_helper"

describe "Display A List Of Songs Test" do

  describe "the list of your own songs" do
    #these test would rely on real facebook responeses
    #we have to look into facebooktest users if they can make these tests more reliable

    it "displays invite friend Button if user has no permission" do
      visit '/100001114200099/Tini_Waitforit_Ziminzke'
      page.must_have_content('zu fb-mukke einladen')
    end

    it "renders The youtube and the soundcloud Player" do
      visit '/'
      page.must_have_css('.from_youtube')
      page.must_have_css('.from_soundcloud')
    end
  end
end