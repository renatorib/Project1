class FirstStepsController < ApplicationController
 	respond_to :html, :xml 
 	
	def shipper_info
		@shipper = Shipper.new
		@new_user = User.new
		respond_with(@shipper)		
	end

	def shipper_info_filled
		@user = User.new(email: params["email"], password: params["password"])
		# user.save
		# sign_in user
		
		@shipper = Shipper.new(name: 						 params["name"], 
													cnpj:              params["cnpj"], 
													cep:               params["cep"], 
													city:              City.find(params["city"]["id"]), 
													address:           params["address"], 
													address_number:    params["address_number"], 
													phone:             params["phone"], 
													alternative_phone: params["alternative_phone"])
		# shipper.save

		redirect_to :pricing
	end

	def pricing
		
	end

	def pricing_choosed
		redirect_to :first_contacts
	end

	def first_contacts
		@contacts = []
	end

	def contact_added
		binding.pry

		contact =	Contact.new(shipper: @shipper, user: @user, name: params[:name], email: params[:email], celphone: params[:celphone])
		@contacts << contact		
	end	

	def contacts_confirmed
		
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
		params.permit(:user)		
  end

end
