class UploadsController < ApplicationController
 
 	def index
		@uploads = Upload.all
	end
  
	def show
		@upload = Upload.find(params[:id])
	end
	
	def new
  	@upload = Upload.new
	end

	def create
		@upload = Upload.new(upload_params)
		if @upload.save
			flash[:success] = "upload sucessful"
			redirect_to dashboard_path
		else
			render 'new'
		end
	end

	private
		
	def upload_params
		params.require(:upload).permit(:name, :description, :price)
	end
end
