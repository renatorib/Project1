class FreightsController < ApplicationController
 	before_filter :authenticate_user!
 	respond_to :html, :xml 

	def index
		@freights = FreightManager.collect(current_user.shipper)
		respond_with(@freights)
	end

	def new
		@freight = FreightManager.build(current_user.shipper)
	  respond_with(@freight)
	end

	def create
		freight = FreightManager.save(current_user.shipper, params)
	  flash[:notice] = "Successfully created freight." if freight.valid?
		respond_with(freight)
	end

	def edit
		@freight = Freight.find(params[:id])
	  respond_with(@freight)		
	end

	def update
		freight = FreightManager.save(current_user.shipper, params)
	  flash[:notice] = "Successfully updated freight." if freight.valid?
	  respond_with(freight)
	end

	def show
		redirect_to freights_path		
	end

  def destroy  
  	flash[:notice] = "Successfully cancelled freight." if FreightManager.cancel(params[:id])
    redirect_to freights_path
  end

  private

  def freight_params    
		params.require(:freight).permit("expiration(3i)", "expiration(2i)", "expiration(1i)", 
																		"shipment(3i)"	, "shipment(2i)"	, "shipment(1i)"	, 
																		:origin_id			, :destination_id	, :weigth					, 
																		:urgency				, :price					, :description		, 
																		:tracked				, :insured				, :heigth					, 
																		:width					, :length					, :amount					, 
																		:situation			, origin: [:id, :name], destination: [:id, :name])
  end

end