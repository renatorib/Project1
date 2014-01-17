require "spec_helper"

describe Country do
	it { should have_many(:states) }
	it { should validate_uniqueness_of(:name)	}	
	it { should validate_presence_of(:name)	}		
end