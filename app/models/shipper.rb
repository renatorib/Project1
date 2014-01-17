class Shipper < ActiveRecord::Base
  belongs_to :city
  has_many :freights
  has_many :contacts

  validates_uniqueness_of :name, :cnpj
  validates_presence_of :name, :cnpj, :address, :phone
  validates :cnpj, :cnpj => true
  validates_format_of :cep, with: /^[0-9]{5}-?[0-9]{3}$/, multiline: true
end
