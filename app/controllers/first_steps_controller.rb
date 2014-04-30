class FirstStepsController < ApplicationController
	before_filter :authenticate_user!, :only => [:pricing, :first_contacts, :first_freight]	
 	respond_to :html, :xml 
 	
	def shipper_info
		@shipper  = Shipper.new
		@new_user = User.new
		respond_with(@shipper)		
	end

	def shipper_info_filled
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

	def pricing_choosed
		redirect_to :first_contacts
	end

	def first_contacts
		@contacts = current_user.shipper.contacts
	end

	def contact_added
		binding.pry

		contact =	Contact.new(shipper: current_user.shipper, user: current_user, name: params[:name], email: params[:email], celphone: params[:celphone])
		contact.save

		@contacts = current_user.shipper.contacts		

		render partial: "contacts_list"
	end	

	def add_contact
		contact = Contact.new(shipper: current_user.shipper, name: params[:name], email: params[:email], celphone: params[:celphone])

		password_length = 8
		password        = Devise.friendly_token.first(password_length)
		user            = User.new(email: params[:email], contact: contact, password: password, password_confirmation: password) 
		p contact.valid?
		p contact.errors.messages

		p user.valid?
		p user.errors.messages
		
		contact.save
		user.save

		@contacts = current_user.shipper.contacts		

		render partial: 'contacts_list'
	end

	def contacts_confirmed
	# devise new user (confirmation email)	
		redirect_to :first_freight
	end

	def first_freight


	end

	def first_freight_generated

		redirect_to :admin
	end

	private

  def first_step_params    
		# params.require(:user).permit(:id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at, :contact_id)
		params.permit(:user).permit(:contact)
  end

end
