class FirstStepsController < ApplicationController
 	respond_to :html, :xml 
 	
	def shipper_form
		@shipper = Shipper.new
		@new_user = User.new
		respond_with(@shipper)		
	end

	def first_page
		binding.pry
# <%= collection_select(:city_id, City.all, :id, :name, {}, {class: "span5"}) %>
		redirect_to :billing
	end

	def billing

	end

	private

  def first_step_params    
		# params.require(:user).permit(:id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at, :contact_id)
		params.permit(:user)		
  end

end
