class Freight < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :origin, class_name: 'City'
  belongs_to :destination, class_name: 'City'
  has_many :contacts, through: :shipper  

  HIGH = "high"
  NORMAL = "normal"
  URGENCIES = [Freight::HIGH, Freight::NORMAL]

  BID = "bid"
  WAITING = "waiting"
  TRANSPORT = "transport"
  DELIVERED = "delivered"
  FINALIZED = "finalized"
  CANCELLED = "cancelled"
  SITUATIONS = [Freight::BID, 
                Freight::WAITING, 
                Freight::TRANSPORT, 
                Freight::DELIVERED, 
                Freight::FINALIZED, 
                Freight::CANCELLED]
                
  validates_inclusion_of :urgency, in: URGENCIES
  validates_inclusion_of :situation, in: SITUATIONS
  validates :expiration, presence: true, expiration: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :heigth, greater_than_or_equal_to: 0  
  validates_numericality_of :weigth, greater_than_or_equal_to: 0  
  validates_numericality_of :length, greater_than_or_equal_to: 0  
  validates_numericality_of :width, greater_than_or_equal_to: 0   
  validates_numericality_of :amount, greater_than_or_equal_to: 0



end