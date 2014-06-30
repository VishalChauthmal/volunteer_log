class AughoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

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
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-08-01")
	end

	private
		def aughour_params
			params.require(:aughour).permit(:date, :numhours)		
		end

		def create_correct_month
			@aughour = 	current_user.aughours.build(aughour_params)
			if !@aughour.date.nil? && @aughour.date.strftime("%m") != "08"
				redirect_to aughours_path, notice: "The month is not correct."
			end
			if !current_user.aughours.find_by(date: @aughour.date).nil?
				redirect_to aughours_path, notice: "You already submitted the log for this date."
			end
		end

		def update_correct_month
			if !params[:aughour][:date].nil? && (Date.parse(params[:aughour][:date])).strftime("%m") != "08"
				redirect_to aughours_path, notice: "The month is not correct."
			end
		end
end
