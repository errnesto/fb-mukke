require "test_helper"

describe User do
	before do
		@authHash = OmniAuth.config.mock_auth[:facebook] 
	end

	it "stores user information" do
		id = User.from_omniauth(@authHash)
		@user = User.find(id)

		@user.uid.must_be :==, '1234567'
		@user.first_name.must_be :==, 'Joe'
		@user.oauth_token.must_be :==, 'ABCDEF...'
		@user.oauth_expires_at.must_be :==, '2011-11-20 01:00:05'

	end
end