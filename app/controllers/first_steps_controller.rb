class FirstStepsController < ApplicationController
	before_filter :authenticate_user!, :only => [:pricing, :first_contacts, :first_freight]	
 	respond_to :html, :xml, :json, :js
 	
	def shipper
		@shipper  = Shipper.new
		@new_user = User.new
		respond_with(@shipper)		
	end

	def shipper_confirmed
		shipper = Shipper.new(name: 						 params["name"], 
													cnpj:              params["cnpj"], 
													cep:               params["cep"], 
													city:              City.find(params["city"]["id"]), 
													address:           params["address"], 
													address_number:    params["address_number"], 
													phone:             params["phone"], 
													alternative_phone: params["alternative_phone"])

		name    = params["email"].split("@").first
		contact = Contact.new(shipper: shipper, name: name, email: params["email"])
		user    = User.new(email: params["email"], password: params["password"], contact: contact)
		binding.pry

		shipper.save
		contact.save(validate: false)
		user.save
		sign_in user	

		redirect_to :pricing
	end

	def pricing
		
	end

	def pricing_confirmed
		redirect_to :first_contacts
	end

	def first_contacts
		@contacts = current_user.shipper.contacts
	end

	def add_contact
		contact = Contact.new(shipper: current_user.shipper, name: params[:name], email: params[:email], celphone: params[:celphone])

		password_length = 8
		password        = Devise.friendly_token.first(password_length)
		user            = User.new(email: params[:email], contact: contact, password: password, password_confirmation: password) 

		respond_to do |format|
	    if contact.save && user.save
				@contacts = current_user.shipper.contacts	    	
				format.js
	    else
	      format.js { render('/error_messages', locals: {object: contact}, status: :unprocessable_entity)}
	    end
	  end

	end

	def contacts_confirmed
	# devise new user (confirmation email)	
		redirect_to :first_freight
	end

	def first_freight
		@freight = FreightManager.build(current_user.shipper)
	end

	def freight_confirmed		
		freight = FreightManager.save(current_user.shipper, first_step_params)
    if freight.valid?
    	redirect_to freights_path
    else
			respond_to do |format|
	      format.js { render('/error_messages', locals: {object: freight}, status: :unprocessable_entity)}
	    end
	  end
	end

	private

  def first_step_params    
		params.permit(:user).permit(:contact)
		params.permit(:expiration		 , :shipment	 , :origin_id, 
									:destination_id, :weigth		 , :urgency	 , 
									:price				 , :description, :tracked	 , 
									:insured			 , :heigth		 , :width		 , 
									:length				 , :amount		 , :situation, 
									origin: [:id, :name], destination: [:id, :name])
  end
end
