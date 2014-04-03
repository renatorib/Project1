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

			@params = {"freight" => {"expiration(3i)" => "17",
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
			pending
			freight = FreightManager.save(@shipper, @params)
				
			freight.valid?			
			p freight
			p freight.errors
			
			expect(freight.expiration.to_date).to eql("17/08/2016".to_date)
			expect(freight.shipment.to_date).to eql("18/08/2016".to_date)
			expect(freight.valid?).to eql(true)
			expect(freight.situation).to eql("high")
			expect(freight.situation).to eql("high")
			expect(freight.tracked).to eql(true)
			expect(freight.insured).to eql(true)
			expect(freight.price).to eql(5000)
			expect(freight.description).to eql("test")
			expect(freight.heigth).to eql(70)
			expect(freight.width).to eql(60)			
			expect(freight.weigth).to eql(50)
			expect(freight.length).to eql(40)
			expect(freight.amount).to eql(30)

			expect(freight.freight_contacts.count).to eql(2)
		end

		it "when an existent freight" do
			pending
			@params["action"] = "update"
			@params["id"] = "18"
		end
	end
end