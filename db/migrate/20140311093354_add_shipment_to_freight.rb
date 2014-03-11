class AddShipmentToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :shipment, :datetime
  end
end
