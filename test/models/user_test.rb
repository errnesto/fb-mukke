require "test_helper"

describe User do
	before do
		id = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
		@user = User.find(id)
	end

	it "stores user information" do

		@user.uid.must_be :==, '100003562633226'
		@user.first_name.must_be :==, 'Wunderundfitzig'
		@user.oauth_token.must_be :==, 'CAAHONCAfHIIBAJRLmroOYudfZCWRDnKktde73YYNNCooHZCMqHfuTvi6sylmKOPbgseXQZBSAprXz7w2yxFB9ZA36elbR0RgOggp741rZBCeMn8Er1dMI4NmZCaymVJC22bc8UcT1KlIKJ2LZBdy3SISvJqbU1wFREZD'
		@user.oauth_expires_at.must_be :==, '2011-11-20 01:00:05'
	end

	it "gets links from facebook" do
		songs = @user.getSongsFromFacebook
		songs.must_be_kind_of Array
	end
end