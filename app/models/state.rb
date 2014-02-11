class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities

  validates_uniqueness_of :name, :acronym
  validates_presence_of :name, :acronym
  # validates_length_of :acronym, is: 2
end
