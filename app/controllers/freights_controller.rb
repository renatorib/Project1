class FreightsController < ApplicationController
 	respond_to :html, :xml 
 	before_filter :authenticate_user!

	def index
		@freights = Freight.from_shipper(current_user.shipper)
		respond_with(@freights)
	end

	def new
		@freight = Freight.new(shipper: Shipper.first, situation: Freight::WAITING, urgency: Freight::NORMAL)
	  respond_with(@freight)
	end

	def create		
		@freight = Freight.new(freight_params)
		@freight.situation = Freight::WAITING
	  flash[:notice] = "Successfully created product." if @freight.save
		respond_with(@freight)	  
	end

	def edit
		@freight = Freight.find(params[:id])
	  respond_with(@freight)		
	end

	def update
		@freight = Freight.find(params[:id])		  
	  flash[:notice] = "Successfully updated product." if @freight.save
	  respond_with(@freight)
	end

	def show
		redirect_to freights_path		
	end

  def destroy  
    freight = Freight.find(params[:id])  
    freight.situation = Freight::CANCELLED
    flash[:notice] = "Successfully cancelled product." if freight.save
    redirect_to freights_path
  end

  private

  def freight_params    
		params.require(:freight).permit("expiration(3i)", "expiration(2i)", "expiration(1i)", 
																		:origin_id			, :destination_id	, :weigth					, 
																		:urgency				, :price					, :description		, 
																		:tracked				, :insured				, :heigth					, 
																		:width					, :length					, :amount					, 
																		:situation			, origin: [:id, :name], destination: [:id, :name])
  end

end