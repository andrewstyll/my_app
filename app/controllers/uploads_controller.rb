class UploadsController < ApplicationController
	
	skip_before_filter :verify_authenticity_token, :only => [:payment_token]
	 
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
		#model URL is saved by paperclip check Upload.file.url
		@upload = Upload.new(upload_params)
		@upload.current_status = "uploaded"
		if @upload.save
			flash[:success] = "upload sucessful"
			redirect_to dashboard_path
		else
			render 'new'
		end
	end
	
	def pay
		@upload = Upload.find(params[:upload_id]) 
	end

	def payment_token
		@upload = Upload.find(params[:upload_id])
		Stripe.api_key = "sk_test_d5xSfWEXkyfkgMR9b9RUZNVk"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create the charge on Stripe's servers - this will charge the user's card
		begin
		charge = Stripe::Charge.create(
				:amount => (@upload.price*100).to_i, # amount in cents, again
				:currency => "usd",
				:source => token,
				:description => @upload.name
				)
		rescue Stripe::CardError => e
		# The card has been declined
		end
		@upload.current_status = "Payed"
		@upload.save
		render 'pay'
	end

	private
		
	def upload_params
		params.require(:upload).permit(:name, :description, :price, :file)
	end
end
