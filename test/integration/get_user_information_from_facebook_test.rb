require "test_helper"

describe "Get User Information from fabebook Test" do

  describe "the start page" do
    before do
      #open the start page (needs to call auth/facebook)
      visit '/'
    end

    it "has the right header" do
      page.html.must_have_content('fb-mukke')
    end

    it "displays the correct user name" do
      #change this test later so it just checks the user is logged in
      find("#searchFriend")[:value].must_equal 'Wunderundfitzig'
    end
  end
end