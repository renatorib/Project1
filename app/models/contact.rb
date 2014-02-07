class Contact < ActiveRecord::Base
  belongs_to :shipper
  has_one :user

	validates_presence_of :name, :celphone, :email

end
