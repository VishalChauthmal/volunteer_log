class OrgsController < ApplicationController
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
	end

	private
		def org_params
			params.require(:org).permit(:org_name)	
		end
end
