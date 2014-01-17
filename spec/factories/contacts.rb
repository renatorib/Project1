# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name "MyString"
    phone "MyString"
    celphone "MyString"
    email "MyString"
    skype "MyString"
    shipper nil
  end
end
