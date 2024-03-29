class Freight < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :origin, class_name: 'City'
  belongs_to :destination, class_name: 'City'
  has_many :freight_contacts

  attr_accessor :days_left

  HIGH = "high"
  NORMAL = "normal"
  URGENCIES = [Freight::HIGH, Freight::NORMAL]

  BID = "bid"
  WAITING = "waiting"
  TRANSPORT = "transport"
  DELIVERED = "delivered"
  FINALIZED = "finalized"
  CANCELLED = "cancelled"
  SITUATIONS = [Freight::WAITING, 
                Freight::BID, 
                Freight::TRANSPORT, 
                Freight::DELIVERED, 
                Freight::FINALIZED, 
                Freight::CANCELLED]
                
  validates_inclusion_of :urgency, in: URGENCIES
  validates_inclusion_of :situation, in: SITUATIONS
  validates :expiration, presence: true, expiration: true
  validates :shipment, shipment: true  
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :heigth, greater_than_or_equal_to: 0  
  validates_numericality_of :weigth, greater_than_or_equal_to: 0  
  validates_numericality_of :length, greater_than_or_equal_to: 0  
  validates_numericality_of :width, greater_than_or_equal_to: 0   
  validates_numericality_of :amount, greater_than_or_equal_to: 0

  def is_finished?
    [Freight::DELIVERED, Freight::FINALIZED, Freight::CANCELLED].include?(self.situation)
  end

  def is_waiting?
    self.situation == Freight::WAITING
  end

  def is_high?
    self.urgency == Freight::HIGH
  end

  def is_tracked?
    "is#{self.tracked ? "" : "n't"} tracked"
  end

  def is_insured?
    "is#{self.insured ? "" : "n't"} insured"
  end

  def days_left
    result = (self.expiration - Date.today).to_i rescue nil
    result = 0 if result < 0
    result    
  end

  scope :from_shipper, lambda { |shipper|
    where("shipper_id = ?", shipper.id)
  }

  scope :on_offer, -> { where("situation = 'bid' or situation = 'waiting'") }
  
end