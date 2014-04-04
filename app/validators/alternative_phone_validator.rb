class AlternativePhoneValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)    
    object.errors[attribute] << "must be different from the phone." if !value.blank? && value == object.phone
  end
end