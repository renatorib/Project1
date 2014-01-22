class Freight < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :origin, class_name: 'City'
  belongs_to :destination, class_name: 'City'
  has_many :contacts, through: :shipper  

  validates_inclusion_of :urgency, in: %w(high normal)
  validates_inclusion_of :situation, in: %w(waiting bid transport delivered finalized)
  validates :expiration, :presence => true, :expiration => true
	validates_numericality_of :price, greater_than_or_equal_to: 0
	validates_numericality_of :heigth, greater_than_or_equal_to: 0	
	validates_numericality_of :weigth, greater_than_or_equal_to: 0	
	validates_numericality_of :length, greater_than_or_equal_to: 0	
	validates_numericality_of :width, greater_than_or_equal_to: 0		
	validates_numericality_of :amount, greater_than_or_equal_to: 0
end