require "test_helper"

describe "Get User Information from fabebook Test" do

  describe "the start page" do
    before do
      #open the start page (needs to call auth/facebook)
      visit '/'
    end

    it "has the right header" do
      page.must_have_content('fb-mukke')
    end

    it "displays the correct user id" do
      page.must_have_content('your user id:100003562633226')
    end
  end
end