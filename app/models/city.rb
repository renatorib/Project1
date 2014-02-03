class City < ActiveRecord::Base
  belongs_to :state
  validates_presence_of :name

  def name_with_state
  	"#{self.name} - #{self.state.acronym}"  	
  end
end
