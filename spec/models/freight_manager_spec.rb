require "spec_helper"

describe FreightManager do

	it "should build a freight" do
		freight = FreightManager.build(Shipper.new)
		expect(freight.shipper).to be_an_instance_of(Shipper)
		expect(freight.situation).to eql(Freight::WAITING)
		expect(freight.urgency).to eql(Freight::NORMAL)
	end

	it "should collect freights" do
		allow(FreightManager).to receive(:collect).with(an_instance_of(Shipper)).and_return([double(freight: "Miami")])		
		FreightManager.collect(Shipper.new)
	end

	describe "should save" do
		before :each do
			@shipper = FactoryGirl.create(:shipper, id: 2, name: "contact 123", cnpj: "33640887000131")
			FactoryGirl.create(:contact, id: 2, shipper: @shipper)
			FactoryGirl.create(:contact, id: 3, shipper: @shipper)
			FactoryGirl.create(:city, id: 1)
			FactoryGirl.create(:freight, id: 18)

			@params = {"freight" => {"origin_id" 			=> "1",
													     "destination_id" => "1",
															 "expiration(3i)" => "17",
														   "expiration(2i)" => "8",
														   "expiration(1i)" => "2016",
															 "shipment(3i)"   => "18",
														   "shipment(2i)"   => "8",
														   "shipment(1i)"   => "2016",
														   "urgency"        => "high",
														   "tracked"        => "1",
														   "insured"        => "1",
														   "description"    => "test",
														   "price"          => "5000",
														   "heigth"         => "70",
														   "width"          => "60",
														   "weigth"         => "50",
														   "length"         => "40",
														   "amount"         => "30"},
            		 "contacts" => {"2" => "on", 
            		 								"3" => "on"},
	               "action" => "create",
  			         "controller" => "freights"}
		end

		it "when new freight" do
			freight = FreightManager.save(@shipper, @params)

			expect(freight.shipper.name).to eql(Shipper.find(2).name)			
			expect(freight.expiration.to_date).to eql("17/08/2016".to_date)
			expect(freight.shipment.to_date).to eql("18/08/2016".to_date)
			expect(freight.urgency).to eql("high")
			expect(freight.situation).to eql("waiting")
			expect(freight.tracked).to eql(true)
			expect(freight.insured).to eql(true)
			expect(freight.price).to eql(5000.0)
			expect(freight.description).to eql("test")
			expect(freight.heigth).to eql(70.0)
			expect(freight.width).to eql(60.0)			
			expect(freight.weigth).to eql(50.0)
			expect(freight.length).to eql(40.0)
			expect(freight.amount).to eql(30.0)
			expect(freight.valid?).to eql(true)

			expect(freight.freight_contacts.count).to eql(2)
		end

		it "when an existent freight" do
			@params["action"] = "update"
			@params["id"] = "18"
			@params["freight"].delete("origin_id")
			@params["freight"].delete("destination_id")

			freight = FreightManager.save(@shipper, @params)

			expect(freight.shipper.name).to eql(Shipper.find(2).name)			
			expect(freight.expiration.to_date).to eql("17/08/2016".to_date)
			expect(freight.shipment.to_date).to eql("18/08/2016".to_date)
			expect(freight.urgency).to eql("high")
			expect(freight.situation).to eql("waiting")
			expect(freight.tracked).to eql(true)
			expect(freight.insured).to eql(true)
			expect(freight.price).to eql(5000.0)
			expect(freight.description).to eql("test")
			expect(freight.heigth).to eql(70.0)
			expect(freight.width).to eql(60.0)			
			expect(freight.weigth).to eql(50.0)
			expect(freight.length).to eql(40.0)
			expect(freight.amount).to eql(30.0)
			expect(freight.valid?).to eql(true)
		end

		it "when canceling freight" do
			@params["id"] = "18"
			FreightManager.cancel(@params["id"])
			expect(Freight.find(@params["id"]).situation).to eql(Freight::CANCELLED)
		end

	end
end