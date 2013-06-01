class User < ActiveRecord::Base
	def self.from_omniauth(auth)
		where(auth.slice(:uid)).first_or_initialize.tap do |user|
			user.uid = auth.uid
			user.first_name = auth.info.first_name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end
end
