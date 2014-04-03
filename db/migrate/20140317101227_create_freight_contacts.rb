class CreateFreightContacts < ActiveRecord::Migration
  def change
    create_table :freight_contacts do |t|
      t.references :freight, index: true
      t.references :contact, index: true

      t.timestamps
    end
  end
end
