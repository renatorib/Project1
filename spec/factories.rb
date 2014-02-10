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

  factory :user do
    email "test@test.com"    
    password "12345678"
    password_confirmation "12345678"
    association :contact    
  end
end