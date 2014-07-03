class AprhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@aprhour = current_user.aprhours.build
	end

	def create
		#@aprhour = current_user.aprhours.build(aprhour_params)
		if @aprhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to aprhours_path
		else
			render 'new'
		end
	end

	def edit
		@aprhour = Aprhour.find(params[:id])
	end

	def update
		@aprhour = Aprhour.find(params[:id])
		if @aprhour.update_attributes(aprhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to aprhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_aprhour_path
		@monhours = current_user.aprhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-04-01")
	end

	private
		def aprhour_params
			params.require(:aprhour).permit(:date, :numhours)		
		end

		def create_correct
			@aprhour = 	current_user.aprhours.build(aprhour_params)
			if !@aprhour.date.nil? && @aprhour.date.strftime("%m") != "04"
				redirect_to aprhours_path, notice: "The month is not correct."
			end
			if !current_user.aprhours.find_by(date: @aprhour.date).nil?
				redirect_to aprhours_path, notice: "You already submitted the log for this date."
			end
			if !@aprhour.date.nil? && ((@aprhour.date < current_user.start_date) || (@aprhour.date > Date.today + 1.day))
				redirect_to aprhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:aprhour][:date].nil? && (Date.parse(params[:aprhour][:date])).strftime("%m") != "04"
				redirect_to aprhours_path, notice: "The month is not correct."
			end
			if !params[:aprhour][:date].nil? && ((Date.parse(params[:aprhour][:date]) < current_user.start_date) || (Date.parse(params[:aprhour][:date]) > Date.today + 1.day))
				redirect_to aprhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
