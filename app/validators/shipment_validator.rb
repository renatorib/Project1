class ShipmentValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)
    if object.errors[attribute].blank? && !value.nil?
      if value < DateTime.now.to_date
        object.errors[attribute] << "cannot be soon than today"
      end

      unless object.expiration.nil?
	      if value < object.expiration
	        object.errors[attribute] << "cannot be soon than expiration"
	      end
	    end
    end
  end
end