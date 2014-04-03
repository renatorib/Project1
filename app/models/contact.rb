class Contact < ActiveRecord::Base
  belongs_to :shipper
  has_one :user

	validates_presence_of :name
	validates :email, presence: true, email: true
	validates :celphone, presence: true, phone: true

  scope :available, lambda { where("active = ?", true) }

  scope :of_freight_or_available, lambda { |freight|
  	id = -1
  	id = freight.id if freight && freight.id
		joins("LEFT JOIN Freight_Contacts ON Freight_Contacts.Contact_ID = Contacts.ID AND Freight_Contacts.Freight_ID = #{id}")\
		.where("(Contacts.Active OR Freight_Contacts.Contact_ID IS NOT NULL) ")
  }
end
