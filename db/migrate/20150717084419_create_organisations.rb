class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.text :address
      t.string :postcode, null: false
      t.string :organisation_type
      t.string :phone
      t.string :email
      t.string :website
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
