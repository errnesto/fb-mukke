require 'test_helper'

describe HomeController do
	before do
		session[:user_id] = User.first.id
	end

	it "should get the index" do
		get :index
    	assert_template("index")
	end
end