class FreightsController < ApplicationController

	def index

	end

	def new
		@freight = Freight.new(shipper: Shipper.first)
		@origins = City.all
		@destinations = City.all
	end

	def create
		binding.pry
		@freight = Freight.new(urgency: params[:urgency], price: params[:price], description: params[:description])
		@freight.origin = City.find(params[:origin])
		@freight.destination = City.find(params[:destination])
		@freight.tracked = params[:tracked]
		@freight.insured = params[:insured]
		@freight.price = params[:heigth]
		@freight.heigth = params[:heigth]
		@freight.width = params[:width]
		@freight.weigth = params[:weigth]
		@freight.length = params[:length]
		@freight.amount = params[:amount]
		
		if @freight.save
			redirect_to(action: "index")
		else
			render :nothing
		end 
	end

  private

  def freight_params
    params.require(:freight)
  end

end