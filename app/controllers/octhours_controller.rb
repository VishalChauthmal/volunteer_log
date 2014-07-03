class OcthoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@octhour = current_user.octhours.build
	end

	def create
		#@octhour = current_user.octhours.build(octhour_params)
		if @octhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to octhours_path
		else
			render 'new'
		end
	end

	def edit
		@octhour = Octhour.find(params[:id])
	end

	def update
		@octhour = Octhour.find(params[:id])
		if @octhour.update_attributes(octhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to octhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_octhour_path
		@monhours = current_user.octhours
		if Date.parse("#{Date.today.strftime("%Y")}-10-01") >= current_user.start_date
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-10-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-10-01")			
		end
	end

	private
		def octhour_params
			params.require(:octhour).permit(:date, :numhours)		
		end

		def create_correct
			@octhour = 	current_user.octhours.build(octhour_params)
			if !@octhour.date.nil? && @octhour.date.strftime("%m") != "10"
				redirect_to octhours_path, notice: "The month is not correct."
			end
			if !current_user.octhours.find_by(date: @octhour.date).nil?
				redirect_to octhours_path, notice: "You already submitted the log for this date."
			end
			if !@octhour.date.nil? && ((@octhour.date < current_user.start_date) || (@octhour.date > Date.today))
				redirect_to octhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:octhour][:date].nil? && (Date.parse(params[:octhour][:date])).strftime("%m") != "10"
				redirect_to octhours_path, notice: "The month is not correct."
			end
			if !params[:octhour][:date].nil? && ((Date.parse(params[:octhour][:date]) < current_user.start_date) || (Date.parse(params[:octhour][:date]) > Date.today + 1.day))
				redirect_to octhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
