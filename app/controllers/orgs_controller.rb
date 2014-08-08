class OrgsController < ApplicationController
	
	before_action :signed_in_user

	def new
		@org = Org.new
	end

	def create
		@org = Org.new(org_params)
		if @org.save
			flash[:success] = "New Organization Added Successfully!"
			redirect_to @org
		else
			render 'new'
		end
	end

	def show
		@org = Org.find(params[:id])
	end

	def edit
		@org = Org.find(params[:id])
	end

	def update
		@org = Org.find(params[:id])
		if @org.update_attributes(org_params)
			flash[:success] = "Organization Updated!"
			redirect_to @org
		else
			render 'edit'
		end
	end

	def index
		@orgs = Org.all
	end

	def destroy
		flash[:alert] = "Sorry! Deleting an organization is not advisable."
		redirect_to users_path
	end

	private
		def org_params
			params.require(:org).permit(:org_name)	
		end
end
