class MainController < ApplicationController
	before_filter :authenticate_user!, :only => [:login]
	respond_to :html, :xml

	def index
		@freights = Freight.on_offer.sort_by{|f| [f.urgency, f.days_left, f.price]}		
		respond_with(@freights)		
	end

	def login
	end
	
end