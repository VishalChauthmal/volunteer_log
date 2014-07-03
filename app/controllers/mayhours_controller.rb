class MayhoursController < ApplicationController

	before_action :signed_in_user
	before_action :create_correct, only: [:create]
	before_action :update_correct, only: [:update]

	def new
		@mayhour = current_user.mayhours.build
	end

	def create
		#@mayhour = current_user.mayhours.build(mayhour_params)
		if @mayhour.save
			flash[:success] = "Volunteer Log updated successfully!"
			redirect_to mayhours_path
		else
			render 'new'
		end
	end

	def edit
		@mayhour = Mayhour.find(params[:id])
	end

	def update
		@mayhour = Mayhour.find(params[:id])
		if @mayhour.update_attributes(mayhour_params)
			flash[:success] = "Volunteer Log Updated!"
			redirect_to mayhours_path
		else
			render 'edit'
		end
	end

	def show
	end

	def index
		@newpath = new_mayhour_path
		@monhours = current_user.mayhours
		@date = params[:year] ? Date.parse(params[:year]) : Date.parse("#{Date.today.strftime("%Y")}-05-01")
	end

	private
		def mayhour_params
			params.require(:mayhour).permit(:date, :numhours)		
		end

		def create_correct
			@mayhour = 	current_user.mayhours.build(mayhour_params)
			if !@mayhour.date.nil? && @mayhour.date.strftime("%m") != "05"
				redirect_to mayhours_path, notice: "The month is not correct."
			end
			if !current_user.mayhours.find_by(date: @mayhour.date).nil?
				redirect_to mayhours_path, notice: "You already submitted the log for this date."
			end
			if !@mayhour.date.nil? && ((@mayhour.date < current_user.start_date) || (@mayhour.date > Date.today + 1.day))
				redirect_to mayhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end

		def update_correct
			if !params[:mayhour][:date].nil? && (Date.parse(params[:mayhour][:date])).strftime("%m") != "05"
				redirect_to mayhours_path, notice: "The month is not correct."
			end
			if !params[:mayhour][:date].nil? && ((Date.parse(params[:mayhour][:date]) < current_user.start_date) || (Date.parse(params[:mayhour][:date]) > Date.today + 1.day))
				redirect_to mayhours_path, notice: "You cannot submit the logs for future dates
													or dates prior to your joining."
			end
		end
end
