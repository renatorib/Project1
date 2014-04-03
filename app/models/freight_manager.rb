class FreightManager

	def self.build(shipper)
		Freight.new(shipper: shipper, situation: Freight::WAITING, urgency: Freight::NORMAL)
	end

	def self.save(shipper, params)
		@freight             = Freight.find_or_initialize_by(id: params["id"])				
		@freight.shipper     = shipper
		@freight.origin      = City.find(params["freight"]["origin_id"]) if @freight.new_record? 
		@freight.destination = City.find(params["freight"]["destination_id"]) if @freight.new_record?
		@freight.situation   = Freight::WAITING if @freight.new_record?
		@freight.price       = params["freight"]["price"].to_f if params["freight"]["price"]	
		@freight.description = params["freight"]["description"]
		@freight.heigth      = params["freight"]["heigth"].to_f
		@freight.width       = params["freight"]["width"].to_f
		@freight.weigth      = params["freight"]["weigth"].to_f
		@freight.length      = params["freight"]["length"].to_f
		@freight.amount      = params["freight"]["amount"].to_f
		@freight.urgency     = params["freight"]["urgency"]
		@freight.expiration  = "#{params['freight']['expiration(3i)']}/#{params['freight']['expiration(2i)']}/#{params['freight']['expiration(1i)']}".to_date if params['freight']['expiration(3i)']
		@freight.shipment    = "#{params['freight']['shipment(3i)']}/#{params['freight']['shipment(2i)']}/#{params['freight']['shipment(1i)']}".to_date
		@freight.tracked     = params["freight"]["tracked"].to_i
		@freight.insured     = params["freight"]["insured"].to_i
		
		params["contacts"].keys.each do |contact_id|			
			contact = FreightContact.find_or_initialize_by(contact_id: contact_id, freight_id: @freight.id)
			contact.freight = @freight
			contact.contact = Contact.find(contact_id)

			@freight.freight_contacts << contact
		end

		FreightContact.where(freight_id: @freight.id).each do |contact|
			contact.delete unless params["contacts"].keys.include?(contact.contact_id.to_s)
		end

		@freight.save
		@freight
	end

	def self.cancel(id)
    freight = Freight.find(id)  
    freight.situation = Freight::CANCELLED
    freight.save(validate: false)
	end

	def self.collect(shipper)
		Freight.from_shipper(shipper)
	end
end