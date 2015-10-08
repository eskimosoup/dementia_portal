class AddActiveResourcesCountToTargetGroup < ActiveRecord::Migration
  def change
    add_column :target_groups, :active_resources_count, :integer, default: 0
  end
end
