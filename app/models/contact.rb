class Contact < ActiveRecord::Base
  belongs_to :shipper
  has_one :user

	validates_presence_of :name
	validates :email, presence: true, email: true
	validates :celphone, presence: true, phone: true

  scope :available, lambda { where("active = ?", true) }

end
