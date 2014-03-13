class ContactsController < ApplicationController
 	before_filter :authenticate_user!
 	respond_to :html, :xml 

	def index
		@contacts = Contact.find_all_by_shipper_id(current_user.shipper.id)
		respond_with(@contacts)
	end

	def new
		@contact = Contact.new(shipper: current_user.shipper, active: :true)
	  respond_with(@contact)
	end

	def create		
		@contact = Contact.new(shipper: current_user.shipper, active: :true)
		@contact.update_attributes!(contact_params)
	  flash[:notice] = "Successfully created freight." if @contact.save
		respond_with(@contact)	  
	end

	def edit
		@contact = Contact.find(params[:id])
	  respond_with(@contact)
	end

	def update
		@contact = Contact.find(params[:id])		  
		@contact.update_attributes!(contact_params)
	  flash[:notice] = "Successfully updated contact." if @contact.save
	  respond_with(@contact)
	end

  def destroy  
    contact = Contact.find(params[:id])      
    contact.active = :false
    flash[:notice] = "Successfully inativate contact." if contact.save
    redirect_to contacts_path
  end

	def show
		redirect_to contacts_path		
	end

private

  def contact_params    
		params.require(:contact).permit(:name, :celphone, :email, :active)
  end

end