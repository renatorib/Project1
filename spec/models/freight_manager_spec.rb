require "spec_helper"

describe Freight do

	it "should build a freight" do
		peding
		expect(FreightManager).to receive(:build).and_return(instance_of(Freight))
	end

	it "should collect freights" do
		pending
		expect(FreightManager).to receive(:collect).and_return() #instance_of(Freight))

	end




end