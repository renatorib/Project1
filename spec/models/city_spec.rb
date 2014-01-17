require "spec_helper"

describe City do
	it { should belong_to(:state) }
	it { should validate_presence_of(:name)}
	it { should validate_presence_of(:region)}	
end