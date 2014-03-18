require 'spec_helper'

describe FreightContact do
  it { should belong_to(:contact) }
	it { should belong_to(:freight) }
end
