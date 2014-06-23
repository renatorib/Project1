class FirstStepsController < ApplicationController
	before_filter :authenticate_user!, :only => [:first_freight]
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

		contact = Contact.new(shipper: shipper, name: params["email"].split("@").first.camelize, email: params["email"])
		user    = User.new(email: params["email"], password: params["password"], contact: contact)

		# TODO carregar lista de cidades
		# TODO quando informar CEP, tentar carregar informações
		# TODO demora para enviar email, fazer javascript para esperar, ou colocar envio de email em worker
    unless shipper.valid? && user.valid?
			respond_to do |format|
			# TODO Com dois render, somente renderiza o último...
	      format.js { render('app/assetes/javascripts/sitewide/error_messages', locals: {errors: shipper.errors.messages}, status: :unprocessable_entity)} unless shipper.valid?
	      format.js { render('app/assetes/javascripts/sitewide/error_messages', locals: {errors: user.errors.messages}, status: :unprocessable_entity)} unless user.valid?	      
	     end
    else
			
			shipper.save
			user.save
			contact.save(validate: false)
			#FIXME não redireciona
			redirect_to :pricing
	  end
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
		user    = User.new(email: params[:email], contact: contact) 

		respond_to do |format|
			# TODO Validate uniqueness of contact.email
			# TODO Dont save user here, so do not send confirmation
	    if contact.save && user.save
				@contacts = current_user.shipper.contacts
				format.js
	    else
	      format.js { render('/error_messages', locals: {errors: contact.errors.messages}, status: :unprocessable_entity)}
	    end
	  end

	end

	def contacts_confirmed
		# TODO Send confirmation emails here, not in add_contact
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
	      format.js { render('/error_messages', locals: {errors: freight.errors.messages}, status: :unprocessable_entity)}
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
