class MainController < ApplicationController
	before_filter :authenticate_user!, :only => [:login]
	def index
	end

	def login
	end
	
end