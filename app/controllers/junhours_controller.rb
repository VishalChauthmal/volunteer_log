class JunhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

	def new
		@junhour = current_user.junhours.build
	end

	def create
		#@junhour = current_user.junhours.build(junhour_params)
		if @junhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to junhours_path
		else
			render 'new'
		end
	end

	def edit
		@junhour = Junhour.find(params[:id])
	end

	def update
		@junhour = Junhour.find(params[:id])
		if @junhour.update_attributes(junhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to junhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_junhour_path
		@monhours = current_user.junhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-06-01")
	end

	private
		def junhour_params
			params.require(:junhour).permit(:date, :numhours)		
		end

		def create_correct_month
			@junhour = 	current_user.junhours.build(junhour_params)
			if !@junhour.date.nil? && @junhour.date.strftime("%m") != "06"
				redirect_to junhours_path, notice: "The month is not correct."
			end
			if !current_user.junhours.find_by(date: @junhour.date).nil?
				redirect_to junhours_path, notice: "You already submitted the log for this date."
			end
		end

		def update_correct_month
			if !params[:junhour][:date].nil? && (Date.parse(params[:junhour][:date])).strftime("%m") != "06"
				redirect_to junhours_path, notice: "The month is not correct."
			end
		end
end
