class StaticPagesController < ApplicationController
	def home
		if signed_in?
			@hour = current_user.hours.build
		end
	end

	def help
	end

	def about
	end

	def contact
	end
end
