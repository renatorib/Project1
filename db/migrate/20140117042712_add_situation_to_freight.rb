class AddSituationToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :situation, :string
  end
end
