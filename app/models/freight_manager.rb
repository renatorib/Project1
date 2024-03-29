class FreightManager

	def self.build(shipper)
		Freight.new(shipper: shipper, situation: Freight::WAITING, urgency: Freight::NORMAL)
	end

	def self.save(shipper, params)
		parameters = params
		parameters = params["freight"] if params["freight"]

		@freight             = Freight.find_or_initialize_by(id: parameters["id"])				
		@freight.shipper     = shipper
		@freight.origin      = City.find(parameters["origin"]["id"]) if @freight.new_record? 
		@freight.destination = City.find(parameters["destination"]["id"]) if @freight.new_record?
		@freight.situation   = Freight::WAITING if @freight.new_record?
		@freight.price       = parameters["price"].to_f if parameters["price"]	
		@freight.description = parameters["description"]
		@freight.heigth      = parameters["heigth"].to_f
		@freight.width       = parameters["width"].to_f
		@freight.weigth      = parameters["weigth"].to_f
		@freight.length      = parameters["length"].to_f
		@freight.amount      = parameters["amount"].to_f
		@freight.urgency     = parameters["urgency"]
		@freight.expiration  = parameters["expiration"].to_date rescue ""
		@freight.shipment    = parameters["shipment"].to_date rescue ""
		@freight.tracked     = parameters["tracked"].to_i
		@freight.insured     = parameters["insured"].to_i
		@freight.save

		params["contacts"].keys.each do |contact_id|			
			contact         = FreightContact.find_or_initialize_by(contact_id: contact_id, freight_id: @freight.id)
			contact.freight = @freight
			contact.contact = Contact.find(contact_id)

			@freight.freight_contacts << contact
		end if params["contacts"]

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