require "spec_helper"

describe Freight do
	it { should belong_to(:shipper) }
	it { should have_many(:contacts).through(:shipper) }	
	it { should belong_to(:origin).class_name('City') }
	it { should belong_to(:destination).class_name('City') }

	it { should ensure_inclusion_of(:urgency).in_array(%w(high normal)) }
	it { should ensure_inclusion_of(:situation).in_array(%w(waiting bid transport delivered finalized)) }
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
end