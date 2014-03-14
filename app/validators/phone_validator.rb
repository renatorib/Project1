class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
  	unless value.nil? || value.blank?
	    value.delete!(" ")
	    value = value[4..80] if value[0..3] == "0800"
	    value = value[1..80] if value[0] == "0"

	    record.errors.add attribute, (options[:message] || "is not an valid phone.") unless
	      [8, 10, 11].include?(value.length) && (value =~ /[a-zA-Z]/).nil?

	  end
  end
end