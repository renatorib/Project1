class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :cpf
      t.string :phone
      t.string :celphone
      t.string :address
      t.string :district
      t.string :cep
      t.references :city, index: true

      t.timestamps
    end
  end
end
