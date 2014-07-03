class SephoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@sephour = current_user.sephours.build
	end

	def create
		#@sephour = current_user.sephours.build(sephour_params)
		if @sephour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to sephours_path
		else
			render 'new'
		end
	end

	def edit
		@sephour = Sephour.find(params[:id])
	end

	def update
		@sephour = Sephour.find(params[:id])
		if @sephour.update_attributes(sephour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to sephours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_sephour_path
		@monhours = current_user.sephours
		if Date.parse("#{Date.today.strftime("%Y")}-09-01") >= current_user.start_date
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-09-01")
		else
			@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{(Date.today+1.year).strftime("%Y")}-09-01")			
		end
	end

	private
		def sephour_params
			params.require(:sephour).permit(:date, :numhours)		
		end

		def create_correct
			@sephour = 	current_user.sephours.build(sephour_params)
			if !@sephour.date.nil? && @sephour.date.strftime("%m") != "09"
				redirect_to sephours_path, notice: "The month is not correct."
			end
			if !current_user.sephours.find_by(date: @sephour.date).nil?
				redirect_to sephours_path, notice: "You already submitted the log for this date."
			end
			if !@sephour.date.nil? && ((@sephour.date < current_user.start_date) || (@sephour.date > Date.today + 1.day))
				redirect_to sephours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:sephour][:date].nil? && (Date.parse(params[:sephour][:date])).strftime("%m") != "09"
				redirect_to sephours_path, notice: "The month is not correct."
			end
			if !params[:sephour][:date].nil? && ((Date.parse(params[:sephour][:date]) < current_user.start_date) || (Date.parse(params[:sephour][:date]) > Date.today + 1.day))
				redirect_to sephours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
