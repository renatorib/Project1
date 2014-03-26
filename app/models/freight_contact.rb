class FreightContact < ActiveRecord::Base
  belongs_to :freight
  belongs_to :contact

end
