require 'spec_helper'

describe Contact do
	it { should belong_to(:shipper) }	
	it { should have_many(:freights).through(:shipper) }		
	it { should validate_presence_of(:name)}
	it { should validate_presence_of(:celphone)}
	it { should validate_presence_of(:email)}
end
