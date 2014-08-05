class AughoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@aughour = current_user.aughours.build
	end

	def create
		#@aughour = current_user.aughours.build(aughour_params)
		if @aughour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to aughours_path
		else
			render 'new'
		end
	end

	def edit
		@aughour = Aughour.find(params[:id])
	end

	def update
		@aughour = Aughour.find(params[:id])
		if @aughour.update_attributes(aughour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to aughours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_aughour_path
		@monhours = current_user.aughours
		if Date.parse("#{Date.today.strftime("%Y")}-08-01") >= Date.parse("#{current_user.start_date.strftime("%Y-%m")}-01")
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-08-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-08-01")			
		end
	end

	private
		def aughour_params
			params.require(:aughour).permit(:date, :numhours)		
		end

		def create_correct
			@aughour = 	current_user.aughours.build(aughour_params)
			if !@aughour.date.nil? && @aughour.date.strftime("%m") != "08"
				redirect_to aughours_path, notice: "The month is not correct."
			end
			if !current_user.aughours.find_by(date: @aughour.date).nil?
				redirect_to aughours_path, notice: "You already submitted the log for this date."
			end
			if !@aughour.date.nil? && ((@aughour.date < current_user.start_date) || (@aughour.date > Date.today + 1.day))
				redirect_to aughours_path, notice: "You cannot submit the logs for future dates 
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:aughour][:date].nil? && (Date.parse(params[:aughour][:date])).strftime("%m") != "08"
				redirect_to aughours_path, notice: "The month is not correct."
			end
			if !params[:aughour][:date].nil? && ((Date.parse(params[:aughour][:date]) < current_user.start_date) || (Date.parse(params[:aughour][:date]) > Date.today + 1.day))
				redirect_to aughours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
