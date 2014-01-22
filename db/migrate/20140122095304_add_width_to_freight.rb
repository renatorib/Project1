class AddWidthToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :width, :float
  end
end
