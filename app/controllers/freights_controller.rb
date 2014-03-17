class FreightsController < ApplicationController
 	before_filter :authenticate_user!
 	respond_to :html, :xml 

	def index
		@freights = Freight.from_shipper(current_user.shipper)
		respond_with(@freights)
	end

	def new
		@freight = Freight.new(shipper: current_user.shipper, situation: Freight::WAITING, urgency: Freight::NORMAL)
	  respond_with(@freight)
	end

	def create		
		@freight = Freight.new(shipper: current_user.shipper, situation: Freight::WAITING)
		@freight.update_attributes!(freight_params)
	  flash[:notice] = "Successfully created freight." if @freight.save
		respond_with(@freight)	  
	end

	def edit
		@freight = Freight.find(params[:id])
	  respond_with(@freight)		
	end

	def update
		binding.pry
		@freight = Freight.find(params[:id])		  
		@freight.update_attributes!(freight_params)
	  flash[:notice] = "Successfully updated freight." if @freight.save
	  respond_with(@freight)
	end

	def show
		redirect_to freights_path		
	end

  def destroy  
    freight = Freight.find(params[:id])  
    freight.situation = Freight::CANCELLED
    flash[:notice] = "Successfully cancelled freight." if freight.save(validate: false)
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