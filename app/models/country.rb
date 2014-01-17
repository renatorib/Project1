class Country < ActiveRecord::Base
	has_many :states

	validates_uniqueness_of :name
	validates_presence_of :name
end
