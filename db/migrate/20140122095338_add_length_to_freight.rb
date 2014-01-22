class AddLengthToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :length, :float
  end
end
