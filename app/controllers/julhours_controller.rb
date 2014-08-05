class JulhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@julhour = current_user.julhours.build
	end

	def create
		#@julhour = current_user.julhours.build(julhour_params)
		if @julhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to julhours_path
		else
			render 'new'
		end
	end

	def edit
		@julhour = Julhour.find(params[:id])
	end

	def update
		@julhour = Julhour.find(params[:id])
		if @julhour.update_attributes(julhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to julhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_julhour_path
		@monhours = current_user.julhours
		if Date.parse("#{Date.today.strftime("%Y")}-07-01") >= Date.parse("#{current_user.start_date.strftime("%Y-%m")}-01")
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-07-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-07-01")			
		end
	end

	private
		def julhour_params
			params.require(:julhour).permit(:date, :numhours)		
		end

		def create_correct
			@julhour = 	current_user.julhours.build(julhour_params)
			if !@julhour.date.nil? && @julhour.date.strftime("%m") != "07"
				redirect_to julhours_path, notice: "The month is not correct."
			end
			if !current_user.julhours.find_by(date: @julhour.date).nil?
				redirect_to julhours_path, notice: "You already submitted the log for this date."
			end
			if !@julhour.date.nil? && ((@julhour.date < current_user.start_date) || (@julhour.date > Date.today + 1.day))
				redirect_to julhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:julhour][:date].nil? && (Date.parse(params[:julhour][:date])).strftime("%m") != "07"
				redirect_to julhours_path, notice: "The month is not correct."
			end
			if !params[:julhour][:date].nil? && ((Date.parse(params[:julhour][:date]) < current_user.start_date) || (Date.parse(params[:julhour][:date]) > Date.today + 1.day))
				redirect_to julhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
