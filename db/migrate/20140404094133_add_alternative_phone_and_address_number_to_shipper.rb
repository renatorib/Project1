class AddAlternativePhoneAndAddressNumberToShipper < ActiveRecord::Migration
  def change
    add_column :shippers, :alternative_phone, :string
    add_column :shippers, :address_number, :string
  end
end
