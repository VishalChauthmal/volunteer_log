class FebhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@febhour = current_user.febhours.build
	end

	def create
		#@febhour = current_user.febhours.build(febhour_params)
		if @febhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to febhours_path
		else
			render 'new'
		end
	end

	def edit
		@febhour = Febhour.find(params[:id])
	end

	def update
		@febhour = Febhour.find(params[:id])
		if @febhour.update_attributes(febhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to febhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_febhour_path
		@monhours = current_user.febhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-02-01")
	end

	private
		def febhour_params
			params.require(:febhour).permit(:date, :numhours)		
		end

		def create_correct
			@febhour = 	current_user.febhours.build(febhour_params)
			if !@febhour.date.nil? && @febhour.date.strftime("%m") != "02"
				redirect_to febhours_path, notice: "The month is not correct." and return
			end
			if !current_user.febhours.find_by(date: @febhour.date).nil?
				redirect_to febhours_path, notice: "You already submitted the log for this date." and return
			end
			if !@febhour.date.nil? && ((@febhour.date < current_user.start_date) || (@febhour.date > Date.today + 1.day))
				redirect_to febhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining." and return
			end
		end

		def update_correct
			if !params[:febhour][:date].nil? && (Date.parse(params[:febhour][:date])).strftime("%m") != "02"
				redirect_to febhours_path, notice: "The month is not correct." and return
			end
			if !params[:febhour][:date].nil? && ((Date.parse(params[:febhour][:date]) < current_user.start_date) || (Date.parse(params[:febhour][:date]) > Date.today + 1.day))
				redirect_to febhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining." and return
			end
		end
end
