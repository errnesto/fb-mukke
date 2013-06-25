require "test_helper"

describe "Display A List Of Songs Test" do

    #these test would rely on real facebook responeses
    #we have to look into facebooktest users if they can make these tests more reliable

    it "renders The youtube and the soundcloud Player" do
      visit '/'
      page.must_have_css('.from_youtube')
      page.must_have_css('.from_soundcloud')
    end
end