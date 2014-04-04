# encoding : utf-8
FactoryGirl.define do

  factory :country do
    sequence(:name) { |n| "Country #{n}" }        
  end

  factory :state do
    sequence(:name) { |n| "State #{n}" }    
    sequence(:acronym) { |n| "S#{n}" }        
    association :country
  end

  factory :city do
    name "Francisco Beltrão"
    association :state    
  end

  factory :shipper do
    name "Shipper 1"
    address "Addres 1"
    address_number "2332 A"    
    phone "123123123123"
    alternative_phone ""
    cnpj "29692612000174"
    cep "85602210"

    association :city
  end

  factory :contact do
    email "test@testunit.com"    
    name "Barnabe Chinchesky"
    celphone "12345678"
    active true
    association :shipper
  end

  factory :user do
    email "test@testunit.com"    
    password "12345678"
    password_confirmation "12345678"
    association :contact    
  end

  factory :freight do
    urgency "normal"
    situation "waiting"
    expiration Date.today + 10.day
    price 50000
    heigth 1
    weigth 2
    length 3
    width  4
    amount 5

    association :shipper
    association :origin, factory: :city
    association :destination, factory: :city
  end

  factory :freight_contact do
    association :freight
    association :contact
  end
end