class RenameServiceToSubCategory < ActiveRecord::Migration
  def change
    rename_table(:services, :sub_categories)
  end
end
