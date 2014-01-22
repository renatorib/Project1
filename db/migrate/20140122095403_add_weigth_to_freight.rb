class AddWeigthToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :weigth, :float
  end
end
