require 'test_helper'

describe UserController do
	before do
		session[:user_id] = User.first.id
	end

	it "should return Data from a user in json" do
		get :getData
	      response.success?.must_equal true
	      items = JSON.parse(response.body)
	      items.any?{|x| x["name"] == "David Cibis"}.must_equal true
	end

end