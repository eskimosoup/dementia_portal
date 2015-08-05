class AddColourToTargatGroup < ActiveRecord::Migration
  def change
    add_column :target_groups, :colour, :string
  end
end
