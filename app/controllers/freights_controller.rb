class FreightsController < ApplicationController

	def index

	end


	def new
		@freight = Freight.new
	end

end