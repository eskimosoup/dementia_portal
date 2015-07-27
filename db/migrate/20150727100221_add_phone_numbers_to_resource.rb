class AddPhoneNumbersToResource < ActiveRecord::Migration
  def change
    add_column :resources, :main_phone, :string
    add_column :resources, :secondary_phone, :string
  end
end
