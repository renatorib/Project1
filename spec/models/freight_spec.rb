require "spec_helper"

describe Freight do
	it { should belong_to(:shipper) }
	it { should belong_to(:origin).class_name('City') }
	it { should belong_to(:destination).class_name('City') }

	it { should ensure_inclusion_of(:urgency).in_array(%w(high normal)) }
	it { should ensure_inclusion_of(:situation).in_array(%w(waiting bid transport delivered finalized cancelled)) }
	it { should validate_presence_of(:expiration)}	

  it { should allow_value(Date.today).for(:expiration) }
  it { should allow_value(10.days.from_now).for(:expiration)}
  it { should_not allow_value(1.days.ago).for(:expiration)}

  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:heigth).is_greater_than_or_equal_to(0) }  
	it { should validate_numericality_of(:weigth).is_greater_than_or_equal_to(0) }    
	it { should validate_numericality_of(:width).is_greater_than_or_equal_to(0) }    	
	it { should validate_numericality_of(:length).is_greater_than_or_equal_to(0) } 
	it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) } 	

	describe "on look the freight" do

		it "should know if freight is finished" do
			freight = Freight.new(situation: Freight::CANCELLED)
			expect(freight.is_finished?).to eql(true)

			freight = Freight.new(situation: Freight::FINALIZED)
			expect(freight.is_finished?).to eql(true)

			freight = Freight.new(situation: Freight::DELIVERED)
			expect(freight.is_finished?).to eql(true)

			freight = Freight.new(situation: Freight::WAITING)
			expect(freight.is_finished?).to eql(false)

			freight = Freight.new(situation: Freight::BID)
			expect(freight.is_finished?).to eql(false)

			freight = Freight.new(situation: Freight::TRANSPORT)
			expect(freight.is_finished?).to eql(false)
		end

		it "should know if freight is waiting for bids" do
			freight = Freight.new(situation: Freight::WAITING)
			expect(freight.is_waiting?).to eql(true)

			freight = Freight.new(situation: Freight::BID)
			expect(freight.is_waiting?).to eql(false)
		end

		it "should know how left days until expiration" do
			freight = Freight.new(expiration: Date.today + 3.days)
			expect(freight.days_left).to eql(3)

			freight = Freight.new(expiration: Date.today)
			expect(freight.days_left).to eql(0)			

			freight = Freight.new(expiration: Date.today - 15.years)
			expect(freight.days_left).to eql(0)
		end

		it "should know if is high priority" do
			freight = Freight.new(urgency: Freight::HIGH)			
			expect(freight).to be_is_high

			freight = Freight.new(urgency: Freight::NORMAL)
			expect(freight).to_not be_is_high
		end
	end

	describe "on return freights" do

		before :each do
			@shipper = FactoryGirl.create(:shipper)
			@shipper2 = FactoryGirl.create(:shipper, name: "Shipper 2", cnpj: "38518221000129")

			@freight1 = FactoryGirl.create(:freight, shipper: @shipper, situation: "bid")
			@freight2 = FactoryGirl.create(:freight, shipper: @shipper, situation: "waiting")
			@freight3 = FactoryGirl.create(:freight, shipper: @shipper2, situation: "finalized")
		end

		it "should return freights by shipper" do
			expect(Freight.from_shipper(@shipper).count).to eql(2)
			expect(Freight.from_shipper(@shipper2).count).to eql(1)			
		end

		it "should return freights that are on offer" do
			expect(Freight.on_offer.count).to eql(2)
		end
	end


end