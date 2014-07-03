class NovhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@novhour = current_user.novhours.build
	end

	def create
		#@novhour = current_user.novhours.build(novhour_params)
		if @novhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to novhours_path
		else
			render 'new'
		end
	end

	def edit
		@novhour = Novhour.find(params[:id])
	end

	def update
		@novhour = Novhour.find(params[:id])
		if @novhour.update_attributes(novhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to novhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_novhour_path
		@monhours = current_user.novhours
		if Date.parse("#{Date.today.strftime("%Y")}-11-01") >= current_user.start_date
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-11-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-11-01")			
		end
	end

	private
		def novhour_params
			params.require(:novhour).permit(:date, :numhours)		
		end

		def create_correct
			@novhour = 	current_user.novhours.build(novhour_params)
			if !@novhour.date.nil? && @novhour.date.strftime("%m") != "11"
				redirect_to novhours_path, notice: "The month is not correct."
			end
			if !current_user.novhours.find_by(date: @novhour.date).nil?
				redirect_to novhours_path, notice: "You already submitted the log for this date."
			end
			if !@novhour.date.nil? && ((@novhour.date < current_user.start_date) || (@novhour.date > Date.today + 1.day))
				redirect_to novhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:novhour][:date].nil? && (Date.parse(params[:novhour][:date])).strftime("%m") != "11"
				redirect_to novhours_path, notice: "The month is not correct."
			end
			if !params[:novhour][:date].nil? && ((Date.parse(params[:novhour][:date]) < current_user.start_date) || (Date.parse(params[:novhour][:date]) > Date.today + 1.day))
				redirect_to novhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
