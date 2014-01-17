class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :celphone
      t.string :email
      t.string :skype
      t.references :shipper, index: true

      t.timestamps
    end
  end
end
