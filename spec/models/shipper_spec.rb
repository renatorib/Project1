require "spec_helper"

describe Shipper do
	it { should belong_to(:city) }
	it { should have_many(:contacts) }
	it { should have_many(:freights) }	
	it { should validate_presence_of(:name)}
	it { should validate_uniqueness_of(:name)}	
	it { should validate_presence_of(:cnpj)}
	it { should validate_uniqueness_of(:cnpj)}	
	it { should allow_value("53.837.642/0001-06").for(:cnpj)}
	it { should allow_value("53837642000106").for(:cnpj)}	
	it { should_not allow_value("11.111.111/1111-11").for(:cnpj)}	
	it { should validate_presence_of(:phone)}
	it { should validate_presence_of(:address)}
  it { should allow_value('85601000').for(:cep) }
  it { should allow_value('85601-000').for(:cep) }  
  it { should_not allow_value('601000').for(:cep) }
  it { should_not allow_value('a601000').for(:cep) }
end