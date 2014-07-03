class JanhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@janhour = current_user.janhours.build
	end

	def create
		#@janhour = current_user.janhours.build(janhour_params)
		if @janhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to janhours_path
		else
			render 'new'
		end
	end

	def edit
		@janhour = Janhour.find(params[:id])
	end

	def update
		@janhour = Janhour.find(params[:id])
		if @janhour.update_attributes(janhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to janhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_janhour_path
		@monhours = current_user.janhours
		if Date.parse("#{Date.today.strftime("%Y")}-01-01") >= current_user.start_date
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-01-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-01-01")			
		end
	end

	private
		def janhour_params
			params.require(:janhour).permit(:date, :numhours)		
		end

		def create_correct
			@janhour = 	current_user.janhours.build(janhour_params)
			if !@janhour.date.nil? && @janhour.date.strftime("%m") != "01"
				redirect_to janhours_path, notice: "The month is not correct." and return
			end
			if !current_user.janhours.find_by(date: @janhour.date).nil?
				redirect_to janhours_path, notice: "You already submitted the log for this date." and return
			end	
			if !@janhour.date.nil? && ((@janhour.date < current_user.start_date) || (@janhour.date > Date.today + 1.day))
				redirect_to janhours_path, notice: "You cannot submit the logs for future dates 
													or dates prior to your joining." and return
			end
		end

		def update_correct
			if !params[:janhour][:date].nil? && (Date.parse(params[:janhour][:date])).strftime("%m") != "01"
				redirect_to janhours_path, notice: "The month is not correct." and return
			end
			if !params[:janhour][:date].nil? && ((Date.parse(params[:janhour][:date]) < current_user.start_date) || (Date.parse(params[:janhour][:date]) > Date.today + 1.day))
				redirect_to janhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining." and return
			end
		end
end
