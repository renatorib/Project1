require "spec_helper"

describe City do
	it { should belong_to(:state) }
	it { should validate_presence_of(:name)}

	it "should return the state acronym with city name" do
		state = FactoryGirl.create(:state, acronym: "PR") 
		city = FactoryGirl.create(:city, name: "Francisco Beltrão", state: state)
		expect(city.name_with_state).to be_eql("Francisco Beltrão - PR")
	end
end