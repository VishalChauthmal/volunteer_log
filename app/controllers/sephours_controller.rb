class SephoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

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
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-09-01")
	end

	private
		def sephour_params
			params.require(:sephour).permit(:date, :numhours)		
		end

		def create_correct_month
			@sephour = 	current_user.sephours.build(sephour_params)
			if !@sephour.date.nil? && @sephour.date.strftime("%m") != "09"
				redirect_to sephours_path, notice: "The month is not correct."
			end
			if !current_user.sephours.find_by(date: @sephour.date).nil?
				redirect_to sephours_path, notice: "You already submitted the log for this date."
			end
		end

		def update_correct_month
			if !params[:sephour][:date].nil? && (Date.parse(params[:sephour][:date])).strftime("%m") != "09"
				redirect_to sephours_path, notice: "The month is not correct."
			end
		end
end
