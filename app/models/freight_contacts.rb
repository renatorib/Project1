class FreightContacts < ActiveRecord::Base
  belongs_to :freight
  belongs_to :shipper_contact
end
