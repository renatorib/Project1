# encoding : utf-8
FactoryGirl.define do

  factory :country do
    name "Brazil"
  end

  factory :state do
    name "Paraná"
    acronym "PR"    
    association :country
  end

  factory :city do
    name "Francisco Beltrão"
    association :state    
  end
end