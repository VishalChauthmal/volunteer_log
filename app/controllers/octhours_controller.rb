class OcthoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

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
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-10-01")
	end

	private
		def octhour_params
			params.require(:octhour).permit(:date, :numhours)		
		end

		def create_correct_month
			@octhour = 	current_user.octhours.build(octhour_params)
			if !@octhour.date.nil? && @octhour.date.strftime("%m") != "10"
				redirect_to octhours_path, notice: "The month is not correct."
			end
			if !current_user.octhours.find_by(date: @octhour.date).nil?
				redirect_to octhours_path, notice: "You already submitted the log for this date."
			end
		end

		def update_correct_month
			if !params[:octhour][:date].nil? && (Date.parse(params[:octhour][:date])).strftime("%m") != "10"
				redirect_to octhours_path, notice: "The month is not correct."
			end
		end
end
