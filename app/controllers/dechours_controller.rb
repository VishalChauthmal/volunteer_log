class DechoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@dechour = current_user.dechours.build
	end

	def create
		#@dechour = current_user.dechours.build(dechour_params)
		if @dechour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to dechours_path
		else
			render 'new'
		end
	end

	def edit
		@dechour = Dechour.find(params[:id])
	end

	def update
		@dechour = Dechour.find(params[:id])
		if @dechour.update_attributes(dechour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to dechours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_dechour_path
		@monhours = current_user.dechours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-12-01")
	end

	private
		def dechour_params
			params.require(:dechour).permit(:date, :numhours)		
		end

		def create_correct
			@dechour = 	current_user.dechours.build(dechour_params)
			if !@dechour.date.nil? && @dechour.date.strftime("%m") != "12"
				redirect_to dechours_path, notice: "The month is not correct."
			end
			if !current_user.dechours.find_by(date: @dechour.date).nil?
				redirect_to dechours_path, notice: "You already submitted the log for this date."
			end
			if !@dechour.date.nil? && ((@dechour.date < current_user.start_date) || (@dechour.date > Date.today + 1.day))
				redirect_to dechours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:dechour][:date].nil? && (Date.parse(params[:dechour][:date])).strftime("%m") != "12"
				redirect_to dechours_path, notice: "The month is not correct."
			end
			if !params[:dechour][:date].nil? && ((Date.parse(params[:dechour][:date]) < current_user.start_date) || (Date.parse(params[:dechour][:date]) > Date.today + 1.day))
				redirect_to dechours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
