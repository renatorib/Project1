class AddHeigthToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :heigth, :float
  end
end
