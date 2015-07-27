class AddAddressToResource < ActiveRecord::Migration
  def change
    add_column :resources, :address, :text
  end
end
