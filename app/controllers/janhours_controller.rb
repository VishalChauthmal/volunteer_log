class JanhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

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
		@janhours = current_user.janhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-01-01")
	end

	private
		def janhour_params
			params.require(:janhour).permit(:date, :numhours)		
		end

		def create_correct_month
			@janhour = 	current_user.janhours.build(janhour_params)
			if !@janhour.date.nil? && @janhour.date.strftime("%m") != "01"
				redirect_to janhours_path, notice: "The month is not correct."
			end
		end

		def update_correct_month
			if !params[:janhour][:date].nil? && (Date.parse(params[:janhour][:date])).strftime("%m") != "01"
				redirect_to janhours_path, notice: "The month is not correct."
			end
		end
end
