class UsersController < ApplicationController

	before_action :signed_in_user, only: [:edit, :update, :index]
	before_action :correct_user, only: [:edit, :update]

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			if @user.email == "appadmin@atma.org.in"
				@user.update_attributes(admin: true)
			else
				@user.update_attributes(admin: false)
			end
			sign_in @user
			flash[:success] = "Welcome to the Atma Volunteer App"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			if @user.email == "appadmin@atma.org.in"
				@user.update_attributes(admin: true)
			else
				@user.update_attributes(admin: false)
			end
			flash[:success] = "Profile Updated!"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.all
	end

	def logs
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :org_id)
		end

		# before filters

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_url unless current_user?(@user)	
		end
end
