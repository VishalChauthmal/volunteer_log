class HoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]

	def new
		@hour = current_user.hours.build
	end

	def create
		@hour = current_user.hours.build(hour_params)
		if @hour.save
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

		def create_correct
			@hour = current_user.hours.build(hour_params)
			if !@hour.date.nil? && ((@hour.date < current_user.start_date) || (@hour.date > Date.today))
				redirect_to root_url, notice: "You cannot submit the logs for future dates
												or dates prior to your joining."
			end
		end
end
