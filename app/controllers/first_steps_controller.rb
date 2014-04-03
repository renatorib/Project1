class FirstStepsController < ApplicationController
 	respond_to :html, :xml 
 	
	def shipper_form
		@shipper = Shipper.new
		@new_user = User.new
		respond_with(@shipper)		
	end

	def save_shipper
		binding.pry

		redirect_to :billing
	end

	def billing

	end

end
