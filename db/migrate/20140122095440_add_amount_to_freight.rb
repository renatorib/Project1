class AddAmountToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :amount, :float
  end
end
