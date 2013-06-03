require 'test_helper'

describe SessionsController do
	before do
		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
	end

	it "creates a session and redirects to root" do
		get :create
		session[:user_id].must_be_kind_of Integer
		assert_redirected_to('/')
	end

	it "destroys a session and redirects to root" do
		get :destroy
		session[:user_id].must_be_nil
		assert_redirected_to('/')
	end
end