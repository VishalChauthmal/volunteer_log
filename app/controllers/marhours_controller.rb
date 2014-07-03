class MarhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@marhour = current_user.marhours.build
	end

	def create
		#@marhour = current_user.marhours.build(marhour_params)
		if @marhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to marhours_path
		else
			render 'new'
		end
	end

	def edit
		@marhour = Marhour.find(params[:id])
	end

	def update
		@marhour = Marhour.find(params[:id])
		if @marhour.update_attributes(marhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to marhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_marhour_path
		@monhours = current_user.marhours
		if Date.parse("#{Date.today.strftime("%Y")}-03-01") >= current_user.start_date
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-03-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-03-01")			
		end	
	end

	private
		def marhour_params
			params.require(:marhour).permit(:date, :numhours)		
		end

		def create_correct
			@marhour = 	current_user.marhours.build(marhour_params)
			if !@marhour.date.nil? && @marhour.date.strftime("%m") != "03"
				redirect_to marhours_path, notice: "The month is not correct."
			end
			if !current_user.marhours.find_by(date: @marhour.date).nil?
				redirect_to marhours_path, notice: "You already submitted the log for this date."
			end
			if !@marhour.date.nil? && ((@marhour.date < current_user.start_date) || (@marhour.date > Date.today + 1.day))
				redirect_to marhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:marhour][:date].nil? && (Date.parse(params[:marhour][:date])).strftime("%m") != "03"
				redirect_to marhours_path, notice: "The month is not correct."
			end
			if !params[:marhour][:date].nil? && ((Date.parse(params[:marhour][:date]) < current_user.start_date) || (Date.parse(params[:marhour][:date]) > Date.today + 1.day)) 
				redirect_to marhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
