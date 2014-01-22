class FreightsController < ApplicationController

	def index

	end


	def new
		@freight = Freight.new(shipper: Shipper.first)
		@origins = City.all
		@destinations = City.all
	end

end