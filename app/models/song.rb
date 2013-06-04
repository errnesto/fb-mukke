class Song < ActiveRecord::Base
	belongs_to :list
	belongs_to :user

	def isSong?
	end

	def isFrom
	end
end
