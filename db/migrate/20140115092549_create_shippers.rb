class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :name
      t.string :cnpj
      t.string :phone
      t.string :address
      t.string :district
      t.string :cep
      t.references :city, index: true

      t.timestamps
    end
  end
end
