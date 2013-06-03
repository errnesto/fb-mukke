ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
include Capybara::DSL


#Capybara.default_driver = :selenium
#set OmniAuth (used for facebook integration) to test mode
OmniAuth.config.test_mode = true


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  #set up a test facebook user 
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '100003562633226',
    :info => {
      :nickname => 'jbloggs',
      :email => 'joe@bloggs.com',
      :name => 'Joe Bloggs',
      :first_name => 'Wunderundfitzig',
      :last_name => 'Bloggs',
      :image => 'http://graph.facebook.com/1234567/picture?type=square',
      :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
      :location => 'Palo Alto, California',
      :verified => true
    },
    :credentials => {
      :token => 'CAAHONCAfHIIBAJRLmroOYudfZCWRDnKktde73YYNNCooHZCMqHfuTvi6sylmKOPbgseXQZBSAprXz7w2yxFB9ZA36elbR0RgOggp741rZBCeMn8Er1dMI4NmZCaymVJC22bc8UcT1KlIKJ2LZBdy3SISvJqbU1wFREZD', # OAuth 2.0 access_token, which you may wish to store
      :expires_at => 1321747205, # when the access token expires (it always will)
      :expires => true # this will always be true
    },
    :extra => {
      :raw_info => {
        :id => '1234567',
        :name => 'Joe Bloggs',
        :first_name => 'Joe',
        :last_name => 'Bloggs',
        :link => 'http://www.facebook.com/jbloggs',
        :username => 'jbloggs',
        :location => { :id => '123456789', :name => 'Palo Alto, California' },
        :gender => 'male',
        :email => 'joe@bloggs.com',
        :timezone => -8,
        :locale => 'en_US',
        :verified => true,
        :updated_time => '2011-11-11T06:21:03+0000'
      }
    }
  })
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
