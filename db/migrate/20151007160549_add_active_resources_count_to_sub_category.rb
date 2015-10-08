class AddActiveResourcesCountToSubCategory < ActiveRecord::Migration
  def change
    add_column :sub_categories, :active_resources_count, :integer, default: 0
  end
end
