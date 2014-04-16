class MainController < ApplicationController
	before_filter :authenticate_user!, :only => [:login, :accept_freight]
	respond_to :html, :xml

	def index
		@freights = Freight.on_offer.sort_by{|f| [f.urgency, f.days_left, f.price]}		
		respond_with(@freights)		
	end

	def login
	end

	def shipper_start_now
		
		redirect_to :shipper_info
	end

	def bid
		@freight = Freight.find(params[:freight]) 
		respond_with(@freight)
	end

	def accept
		@freight = Freight.find(params[:freight])
		# @freigth.situation = Freight::BID
		# @freight.save
		respond_with(@freight)
	end
end