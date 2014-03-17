require 'spec_helper'

describe Contact do
	it { should belong_to(:shipper) }	
	it { should validate_presence_of(:name)}
	it { should validate_presence_of(:celphone)}
	it { should validate_presence_of(:email)}

	it { should allow_value("8800 1234").for(:celphone)}	
	it { should allow_value("46 8800 1234").for(:celphone)}		
	it { should allow_value("046 8800 1234").for(:celphone)}
	it { should allow_value("046 98800 1234").for(:celphone)}
	it { should_not allow_value("4 8800 1234").for(:celphone)}
	it { should_not allow_value("04 8800 1234").for(:celphone)}
	it { should_not allow_value("0800 1234").for(:celphone)}
	it { should_not allow_value("0800 722 1234").for(:celphone)}	
	it { should_not allow_value("8722 123").for(:celphone)}
	it { should_not allow_value("8722 123a").for(:celphone)}	

	it { should allow_value("contact@contact.com").for(:email)}	
	it { should allow_value("contact@contact.com.br").for(:email)}		
	it { should_not allow_value("contact").for(:email)}
	it { should_not allow_value("contact@").for(:email)}
	it { should_not allow_value("contact@contact").for(:email)}
	it { should_not allow_value("contact@contact.").for(:email)}	

	describe "on return contacts" do

		before :each do
			@shipper = FactoryGirl.create(:shipper)

			contact1 = FactoryGirl.create(:contact, shipper: @shipper, active: true)
			contact2 = FactoryGirl.create(:contact, shipper: @shipper, active: true)
			contact3 = FactoryGirl.create(:contact, shipper: @shipper, active: false)
		end

		it "should return only available contacts" do
			expect(Contact.available.count).to eql(2)
			expect(@shipper.contacts.available.count).to eql(2)
		end
	end
end
