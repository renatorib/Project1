require "spec_helper"

describe City do
	it { should belong_to(:state) }
	it { should validate_presence_of(:name)}

	it "should return the state acronym with city name" do
		city = FactoryGirl.create(:city)
		expect(city.name_with_state).to be_eql("Francisco Beltrão - PR")
	end
end