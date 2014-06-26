class MarhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct_month, only: [:create]
	before_action :update_correct_month, only: [:update]

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
		@monhours = current_user.marhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-03-01")
	end

	private
		def marhour_params
			params.require(:marhour).permit(:date, :numhours)		
		end

		def create_correct_month
			@marhour = 	current_user.marhours.build(marhour_params)
			if !@marhour.date.nil? && @marhour.date.strftime("%m") != "03"
				redirect_to marhours_path, notice: "The month is not correct."
			end
		end

		def update_correct_month
			if !params[:marhour][:date].nil? && (Date.parse(params[:marhour][:date])).strftime("%m") != "03"
				redirect_to marhours_path, notice: "The month is not correct."
			end
		end
end
