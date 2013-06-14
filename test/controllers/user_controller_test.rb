require 'test_helper'

describe UserController do

	it "should return Data from a user in json" do
		get :getData
	      response.success?.must_equal true
	      body.must_equal Item.all.to_json
	      items = JSON.parse(response.body)
	      items.any?{|x| x["name"] == "David Cibis"}.must_equal true
	end

end