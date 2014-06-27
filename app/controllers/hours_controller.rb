class HoursController < ApplicationController

	before_action :signed_in_user

	def new
		@hour = current_user.hours.build
	end

	def create
		@hour = current_user.hours.build(hour_params)
		if @hour.save
			flash[:success] = "Volunteer Log updated successfully!"
			copy_to_correct_month(@hour)
		else
			render 'new'
		end
	end

	def destroy
	end

	private
		def hour_params
			params.require(:hour).permit(:date, :numhours)	
		end
end
