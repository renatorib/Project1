class CreateFreights < ActiveRecord::Migration
  def change
    create_table :freights do |t|
      t.references :shipper, index: true
      t.references :origin, index: true
      t.references :destination, index: true
      t.string :urgency
      t.date :expiration
      t.text :description
      t.float :price
      t.boolean :tracked
      t.boolean :insured

      t.timestamps
    end
  end
end
