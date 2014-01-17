class Contact < ActiveRecord::Base
  belongs_to :shipper
  has_many :freights, through: :shipper

	validates_presence_of :name, :celphone, :email

end
