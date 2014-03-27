class FirstStepsController < ApplicationController
 	respond_to :html, :xml 
	def shipper_form
		@shipper = Shipper.new
		respond_with(@shipper)		
	end

end
