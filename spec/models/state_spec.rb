require "spec_helper"

describe State do
	it { should have_many(:cities) }
	it { should belong_to(:country) }
	it { should validate_uniqueness_of(:name)}
	it { should validate_uniqueness_of(:acronym)}
	it { should validate_presence_of(:name)}
	it { should validate_presence_of(:acronym)}	
 	it { should ensure_length_of(:acronym).is_equal_to(2) }	
end